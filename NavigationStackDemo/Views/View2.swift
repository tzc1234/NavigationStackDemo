//
//  View2.swift
//  NavigationStackDemo
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct View2: View {
    let tap: () -> Void
    let back: () -> Void
    let backToHome: () -> Void
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
            Button("Back", action: back)
            Button("Back to Home", action: backToHome)
        }
        .navigationTitle("View2")
    }
}
