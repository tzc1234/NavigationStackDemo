//
//  PopoverView.swift
//  NavigationStackDemo
//
//  Created by Tsz-Lung on 26/08/2024.
//

import SwiftUI

struct PopoverView: View {
    let tap: () -> Void
    
    var body: some View {
        VStack {
            Button("Hide", action: tap)
        }
    }
}
