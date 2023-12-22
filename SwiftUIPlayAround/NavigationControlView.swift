//
//  NavigationControlView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

final class NavigationControlViewModel: ObservableObject {
    @Published var path = [NextView]()
    
    func push(_ next: NextView) {
        path.append(next)
    }
    
    func popAll() {
        path.removeAll()
    }
}

struct NavigationControlView<Content: View>: View {
    @ObservedObject var viewModel: NavigationControlViewModel
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $viewModel.path, root: content)
    }
}
