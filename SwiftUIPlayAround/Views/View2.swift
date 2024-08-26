//
//  View2.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct View2: View {
    let tap: () -> Void
    let backToHome: () -> Void
    
    init(tap: @escaping () -> Void, backToHome: @escaping () -> Void) {
        self.tap = tap
        self.backToHome = backToHome
    }
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
            Button("Back to Home", action: backToHome)
        }
        .navigationTitle("View2")
    }
}
