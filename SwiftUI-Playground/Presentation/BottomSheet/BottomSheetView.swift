//
//  BottomSheetView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 12/12/25.
//

import SwiftUI

struct BottomSheetView: View {
    @State private var sheetShown = false
    @State private var query = ""
    
    var body: some View {
        Button("Display bottom sheet") {
            sheetShown = true
        }
        .sheet(isPresented: $sheetShown) {
            NavigationStack {
                Text("You query: \(query)")
                    .searchable(text: $query)
                    .navigationTitle(" Search")
            }
//            .interactiveDismissDisabled()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(16)
            .presentationBackground(Material.ultraThin)
            .presentationContentInteraction(.scrolls)
            .presentationBackgroundInteraction(.disabled)
        }
    }
}
