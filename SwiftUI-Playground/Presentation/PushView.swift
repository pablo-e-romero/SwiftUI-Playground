//
//  PushView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Ezequiel Romero Giovannoni on 06/08/2023.
//

import SwiftUI

struct PushView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(value: "Push") {
                    Text("Push")
                }
            }
            .navigationDestination(for: String.self) { value in
                DetailView(viewModel: DetailViewModel())
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PushView()
    }
}
