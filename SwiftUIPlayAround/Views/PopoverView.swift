//
//  PopoverView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct PopoverView: View {
    let tap: () -> Void
    
    init(tap: @escaping () -> Void) {
        self.tap = tap
        print("Popover")
    }
    
    var body: some View {
        VStack {
            Button("Popover Click", action: tap)
        }
    }
}
