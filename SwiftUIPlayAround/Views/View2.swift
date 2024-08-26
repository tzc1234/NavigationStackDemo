//
//  View2.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct View2: View {
    let tap: () -> Void
    let back: () -> Void
    let backToHome: () -> Void
    
    init(tap: @escaping () -> Void, back: @escaping () -> Void, backToHome: @escaping () -> Void) {
        self.tap = tap
        self.back = back
        self.backToHome = backToHome
    }
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
            Button("Back", action: back)
            Button("Back to Home", action: backToHome)
        }
        .navigationTitle("View2")
    }
}
