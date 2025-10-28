//
//  ImageView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 28/10/25.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Image("hello-world")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}
