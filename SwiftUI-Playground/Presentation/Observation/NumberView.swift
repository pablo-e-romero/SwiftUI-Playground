//
//  NumberView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 2/12/25.
//

import SwiftUI

@Observable
final class NumberViewModel {
    var currentNumber = 0
    
    func onIncrementButtonTap() {
        currentNumber += 1
    }
}

struct NumberView: View {
    @State private var tint: Color = Color.accentColor
    
    var body: some View {
        NavigationStack {
            IncrementalNumberView()
                .tint(tint)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ColorPicker("Tint Color", selection: $tint)
                            .labelsHidden()
                    }
                }
        }
    }
}

private struct IncrementalNumberView: View {
    @State var viewModel = NumberViewModel()
 
    var body: some View {
        VStack {
            Text("Count: \(viewModel.currentNumber)")
                .font(.title)
            Button(
                "Increment",
                action: viewModel.onIncrementButtonTap
            )
            .font(.title2)
            .buttonStyle(.borderedProminent)
        }
    }
}
