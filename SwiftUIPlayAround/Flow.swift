//
//  Flow.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

struct NavigationDestination: Hashable {
    private let id = UUID()
    let nextView: AnyView
    
    init(nextView: AnyView) {
        self.nextView = nextView
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
                .navigationDestination(for: NavigationDestination.self) { destination in
                    destination.nextView
                }
            },
            sheet: { [weak self] in
                self?.showSheet?()
            }
        )
    }
    
    private func showView1() {
        viewModel.show(
            NavigationDestination(
                nextView: View1(
                    tap: { [weak self] in self?.showView2() }
                )
                .toAnyView
            )
        )
    }
    
    private func showView2() {
        viewModel.show(
            NavigationDestination(
                nextView: View2(
                    tap: { [weak self] in self?.showView3() },
                    back: { [weak self] in self?.viewModel.popTo(index: 1) },
                    backToHome: { [weak self] in self?.viewModel.popAll() }
                )
                .toAnyView
            )
        )
    }
    
    private func showView3() {
        viewModel.show(
            NavigationDestination(
                nextView: View3(
                    tap: { [weak self] in self?.showPopover() },
                    back: { [weak self] in self?.viewModel.popTo(index: 2) },
                    backToView1: { [weak self] in self?.viewModel.popTo(index: 1) },
                    backToHome: { [weak self] in self?.viewModel.popAll() }
                )
                .toAnyView
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

#Preview {
    Flow(navigationControlViewModel: NavigationControlViewModel()).startView()
}
