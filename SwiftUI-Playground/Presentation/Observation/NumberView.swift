//
//  NumberView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 2/12/25.
//

import SwiftUI

actor NumberHandler {
    var currentNumber = 0
    
    func increment() -> Int {
        print("🧵", "increment", Thread.currentThread)
        currentNumber += 1
        return currentNumber
    }
}

@Observable
final class NumberViewModel {
    var currentNumber: Int?
    private let numberHandler = NumberHandler()
    
    init() {
        Task {
            print("🧵", "init", Thread.currentThread)
            currentNumber = await numberHandler.currentNumber
        }
    }
    
    func onIncrementButtonTap() {
        Task {
            print("🧵", "onIncrementButtonTap", Thread.currentThread)
            currentNumber = await numberHandler.increment()
        }
    }
}

struct NumberView: View {
    @State private var tint: Color = Color.accentColor
    
    var body: some View {
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

private struct IncrementalNumberView: View {
    @State var viewModel = NumberViewModel()
 
    var body: some View {
        VStack {
            Text("Count: \(viewModel.currentNumber ?? -1)")
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
