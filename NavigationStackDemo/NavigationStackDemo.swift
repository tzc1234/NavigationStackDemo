//
//  NavigationStackDemoApp.swift
//  NavigationStackDemo
//
//  Created by Tsz-Lung on 06/10/2023.
//

import SwiftUI

@main
struct NavigationStackDemoApp: App {
    let navigationControlViewModel = NavigationControlViewModel()
    let flow: Flow
    
    init() {
        self.flow = Flow(navigationControlViewModel: navigationControlViewModel)
    }
    
    var body: some Scene {
        WindowGroup(content: flow.startView)
    }
}
