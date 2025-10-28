//
//  DetailView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/10/25.
//

import SwiftUI

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var text: String = "Loading"
   
    private var task: Task<Void, Never>?
    
    deinit {
        task?.cancel()
        print("[HEY]", "SomeViewModel instance deinit")
    }

    func subcribe() async {
        let stream = Emitter.shared.makeStream()
        
        for await value in stream {
            guard !Task.isCancelled else { return }
            self.text = value
            print("[HEY]", "Set \(self.text)")
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
                print("[HEY]", "Task error: \(error)")
            }
        }
    }

    private func executeAsyncTask() async throws {
        print("[HEY]", "Begin async stuff")
        try await Task.sleep(for: .seconds(5))
        print("[HEY]", "Async stuff has been done successfully")
    }
}

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
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
