//
//  CounterView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/10/25.
//

import SwiftUI

@MainActor
final class CounterViewModel: ObservableObject {
    @Published var text: String = "Loading"
   
    private var task: Task<Void, Never>?
    
    deinit {
        task?.cancel()
        print("CounterViewModel", "Instance deinit")
    }

    func subcribe() async {
        print("CounterViewModel", "Subcribe")
        
        let stream = Emitter.shared.makeStream()
        
        for await value in stream {
            guard !Task.isCancelled else { return }
            self.text = value
            print("CounterViewModel", "Set \(self.text)")
        }
    }
    
    func runTask() {
        guard task == nil else { return }
        
        // [weak self] here is not making effect
        task = Task { [weak self] in
            defer { self?.task = nil }
            do {
                try await self?.executeAsyncTask()
            } catch {
                print("CounterViewModel", "Task error: \(error)")
            }
        }
    }

    private func executeAsyncTask() async throws {
        print("CounterViewModel", "Begin async stuff")
        try await Task.sleep(for: .seconds(5))
        print("CounterViewModel", "Async stuff has been done successfully")
    }
}

struct CounterView: View {
    @ObservedObject var viewModel: CounterViewModel
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .task {
                await viewModel.subcribe()
            }
            .onAppear() {
                viewModel.runTask()
            }
    }
}
