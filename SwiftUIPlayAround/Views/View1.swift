//
//  View1.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct View1: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("view1")
    }
    
    var body: some View {
        VStack {
            Button("Next", action: tap)
        }
        .navigationTitle("View1")
    }
}
