//
//  View+AnyView.swift
//  NavigationStackDemo
//
//  Created by Tsz-Lung on 13/12/2023.
//

import SwiftUI

extension View {
    var toAnyView: AnyView {
        AnyView(self)
    }
}
