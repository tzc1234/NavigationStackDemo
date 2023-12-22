//
//  NavigationControlView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

final class NavigationControlViewModel: ObservableObject {
    @Published var path = [NextView]()
    @Published var isShowingSheet = false
    
    func show(_ next: NextView) {
        path.append(next)
    }
    
    func popAll() {
        path.removeAll()
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
    var sheet: () -> AnyView?
    
    var body: some View {
        ZStack {
            NavigationStack(path: $viewModel.path, root: content)
        }.sheet(isPresented: $viewModel.isShowingSheet, content: {
            sheet()
        })
    }
}
