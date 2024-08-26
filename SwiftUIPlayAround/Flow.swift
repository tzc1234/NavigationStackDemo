//
//  Flow.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

struct NextDestination: Hashable {
    let id = UUID()
    private let nextView: () -> Void
    
    init(_ nextView: @escaping () -> Void) {
        self.nextView = nextView
    }
    
    func showNextView() -> NextDestination {
        nextView()
        return self
    }
    
    static func == (lhs: NextDestination, rhs: NextDestination) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class Flow {
    private let viewModel: NavigationControlViewModel
    
    init(navigationControlViewModel: NavigationControlViewModel) {
        self.viewModel = navigationControlViewModel
    }
    
    private var showNextView: (() -> AnyView)?
    private var showSheet: (() -> AnyView)?
    
    @ViewBuilder
    func startView() -> some View {
        NavigationControlView(
            viewModel: viewModel,
            content: {
                HomeView(tap: { [weak self] in
                    self?.showView1()
                })
                .navigationDestination(for: NextDestination.self) { [weak self] _ in
                    self?.showNextView?()
                }
            },
            sheet: sheet
        )
    }
    
    private func sheet() -> AnyView? {
        showSheet?()
    }
    
    private func showView1() {
        viewModel.show(
            NextDestination { [weak self] in
                self?.showNextView = {
                    View1(tap: {
                        self?.showView2()
                    })
                    .toAnyView
                }
            }
            .showNextView()
        )
    }
    
    private func showView2() {
        viewModel.show(
            NextDestination { [weak self] in
                self?.showNextView = {
                    View2(
                        tap: { self?.showPopover() },
                        backToHome: { self?.viewModel.popAll() }
                    )
                    .toAnyView
                }
            }
            .showNextView()
        )
    }
    
    private func showPopover() {
        showSheet = {
            PopoverView(tap: { [weak self] in
                self?.viewModel.hideSheet()
            })
            .toAnyView
        }
        viewModel.showSheet()
    }
}

#Preview {
    Flow(navigationControlViewModel: NavigationControlViewModel()).startView()
}
