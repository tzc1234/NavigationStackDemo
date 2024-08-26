//
//  Flow.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

struct NavigationDestination: Hashable {
    private let id = UUID()
    private let nextView: () -> Void
    
    init(nextView: @escaping () -> Void) {
        self.nextView = nextView
    }
    
    func showNextView() -> NavigationDestination {
        nextView()
        return self
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
                .navigationDestination(for: NavigationDestination.self) { [weak self] _ in
                    self?.showNextView?()
                }
            },
            sheet: { [weak self] in
                self?.showSheet?()
            }
        )
    }
    
    private func showView1() {
        viewModel.show(
            NavigationDestination { [weak self] in
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
            NavigationDestination { [weak self] in
                self?.showNextView = {
                    View2(
                        tap: { self?.showView3() },
                        back: { self?.viewModel.popTo(index: 1) },
                        backToHome: { self?.viewModel.popAll() }
                    )
                    .toAnyView
                }
            }
            .showNextView()
        )
    }
    
    private func showView3() {
        viewModel.show(
            NavigationDestination { [weak self] in
                self?.showNextView = {
                    View3(
                        tap: { self?.showPopover() },
                        back: { self?.viewModel.popTo(index: 2) }, 
                        backToView1: { self?.viewModel.popTo(index: 1) },
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
            PopoverView(
                tap: { [weak self] in
                    self?.viewModel.hideSheet()
                }
            )
            .toAnyView
        }
        viewModel.showSheet()
    }
}

#Preview {
    Flow(navigationControlViewModel: NavigationControlViewModel()).startView()
}
