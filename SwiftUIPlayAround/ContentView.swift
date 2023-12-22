//
//  ContentView.swift
//  SwiftUIPlayAround
//
//  Created by Tsz-Lung on 06/10/2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var inputString = ""
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.blue)
            TextField("Input", text: $viewModel.inputString)
                .multilineTextAlignment(.center)
                .padding(6)
                .background(Color.yellow.opacity(0.7))
                .cornerRadius(8)
                .foregroundColor(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
