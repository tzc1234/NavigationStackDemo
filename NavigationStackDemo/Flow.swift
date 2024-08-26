//
//  Flow.swift
//  NavigationStackDemo
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

struct NavigationDestination<Content: View>: Hashable {
    private let id = UUID()
    let view: Content
    
    init(view: Content) {
        self.view = view
    }
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
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
    
    private var showSheet: (() -> AnyView)?
    
    @ViewBuilder
    func startView() -> some View {
        NavigationControlView(
            viewModel: viewModel,
            content: {
                HomeView(tap: { [weak self] in
                    self?.showView1()
                })
                .navigationDestinationFor(viewType: View1.self)
                .navigationDestinationFor(viewType: View2.self)
                .navigationDestinationFor(viewType: View3.self)
            },
            sheet: { [weak self] in
                self?.showSheet?()
            }
        )
    }
    
    private func showView1() {
        viewModel.show(
            NavigationDestination(
                view: View1(
                    tap: { [weak self] in self?.showView2() }
                )
            )
        )
    }
    
    private func showView2() {
        viewModel.show(
            NavigationDestination(
                view: View2(
                    tap: { [weak self] in self?.showView3() },
                    back: { [weak self] in self?.viewModel.popTo(index: 1) },
                    backToHome: { [weak self] in self?.viewModel.popAll() }
                )
            )
        )
    }
    
    private func showView3() {
        viewModel.show(
            NavigationDestination(
                view: View3(
                    tap: { [weak self] in self?.showPopover() },
                    back: { [weak self] in self?.viewModel.popTo(index: 2) },
                    backToView1: { [weak self] in self?.viewModel.popTo(index: 1) },
                    backToHome: { [weak self] in self?.viewModel.popAll() }
                )
            )
        )
    }
    
    private func showPopover() {
        showSheet = {
            PopoverView(
                tap: { [weak self] in self?.viewModel.hideSheet() }
            )
            .toAnyView
        }
        viewModel.showSheet()
    }
}

struct NavigationDestinationViewModifier<V: View>: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationDestination<V>.self) { destination in
                destination.view
            }
    }
}

extension View {
    func navigationDestinationFor<V: View>(viewType: V.Type) -> some View {
        modifier(NavigationDestinationViewModifier<V>())
    }
}

#Preview {
    Flow(navigationControlViewModel: NavigationControlViewModel()).startView()
}
