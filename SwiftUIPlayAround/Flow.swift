//
//  Flow.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

struct NextView: Hashable {
    let id = UUID()
    let view: AnyView
    
    static func == (lhs: NextView, rhs: NextView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class Flow {
    private let navigationControlViewModel: NavigationControlViewModel
    
    init(navigationControlViewModel: NavigationControlViewModel) {
        self.navigationControlViewModel = navigationControlViewModel
    }
    
    private var makeSheet: (() -> AnyView)?
    
    @ViewBuilder
    func startView() -> some View {
        NavigationControlView(viewModel: navigationControlViewModel, content: {
            StartView(tap: { [weak self] in
                guard let self = self else { return }
                
                self.navigationControlViewModel.show(NextView(view: self.makeView1()))
            })
            .navigationDestination(for: NextView.self) { $0.view }
        }, sheet: getSheet)
    }
    
    private func getSheet() -> AnyView? {
        makeSheet?()
    }
    
    private func makeView1() -> AnyView {
        View1(tap: { [weak self] in
            guard let self else { return }
            
            self.navigationControlViewModel.show(NextView(view: self.makeView2()))
        })
        .toAnyView
    }
    
    private func makeView2() -> AnyView {
        View2(tap: { [weak self] in
            self?.navigationControlViewModel.showSheet()
            self?.makeSheet = {
                PopoverView(tap: {
                    self?.navigationControlViewModel.hideSheet()
                })
                .toAnyView
            }
        })
        .toAnyView
    }
}

struct StartView: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("start")
    }
    
    var body: some View {
        VStack {
            Button("Click0", action: tap)
        }
        .navigationTitle("Start")
    }
}

struct View1: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("view1")
    }
    
    var body: some View {
        VStack {
            Button("Click1", action: tap)
        }
        .navigationTitle("View1")
    }
}

struct View2: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("view2")
    }
    
    var body: some View {
        VStack {
            Button("Click2", action: tap)
        }
        .navigationTitle("View2")
    }
}

struct PopoverView: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("Popover")
    }
    
    var body: some View {
        VStack {
            Button("Popover Click", action: tap)
        }
    }
}
