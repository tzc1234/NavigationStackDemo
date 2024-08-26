//
//  HomeView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct HomeView: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
    }
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
        }
        .navigationTitle("Home")
    }
}
