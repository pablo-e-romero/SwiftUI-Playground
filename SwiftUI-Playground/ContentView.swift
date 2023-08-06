//
//  ContentView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Ezequiel Romero Giovannoni on 06/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("hello-world")
                .resizable()
                .scaledToFit()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            )
            .padding(.all, 16)
            .foregroundStyle(.primary)
            .background(
                Material.thin,
                in: RoundedRectangle(
                    cornerRadius: 16.0,
                    style: .continuous
                )
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
