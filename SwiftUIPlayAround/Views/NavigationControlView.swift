//
//  NavigationControlView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

final class NavigationControlViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var isShowingSheet = false
    
    func show(_ next: some Hashable) {
        path.append(next)
    }
    
    func popAll() {
        path.removeLast(path.count)
    }
    
    func showSheet() {
        isShowingSheet = true
    }
    
    func hideSheet() {
        isShowingSheet = false
    }
}

struct NavigationControlView<Content: View>: View {
    @ObservedObject var viewModel: NavigationControlViewModel
    let content: () -> Content
    let sheet: () -> AnyView?
    
    var body: some View {
        NavigationStack(path: $viewModel.path, root: content)
            .sheet(isPresented: $viewModel.isShowingSheet) {
                sheet()
            }
    }
}
