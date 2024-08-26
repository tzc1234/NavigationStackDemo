//
//  View3.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct View3: View {
    let tap: () -> Void
    let back: () -> Void
    let backToView1: () -> Void
    let backToHome: () -> Void
    
    init(tap: @escaping () -> Void, back: @escaping () -> Void, backToView1: @escaping () -> Void, backToHome: @escaping () -> Void) {
        self.tap = tap
        self.back = back
        self.backToView1 = backToView1
        self.backToHome = backToHome
    }
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
            Button("Back", action: back)
            Button("Back to View1", action: backToView1)
            Button("Back to Home", action: backToHome)
        }
        .navigationTitle("View3")
    }
}
