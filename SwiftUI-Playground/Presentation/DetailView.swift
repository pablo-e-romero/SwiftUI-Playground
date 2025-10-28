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
   
    private let stream: any AsyncSequence<String?, Never>
    private var task: Task<Void, Never>?
    
    deinit {
        task?.cancel()
        print("[HEY]", "SomeViewModel instance deinit")
    }
    
    init() {
        self.stream = Emitter.shared.makeStream(of: \.value)
    }

    func processAsync() async {
        for await value in self.stream {
            guard !Task.isCancelled else { return }
            self.text = value ?? "Empty"
            print("[HEY]", "Set \(self.text)")
        }
    }
    
    func runTask() {
        guard task == nil else { return }
        
        task = Task { [weak self] in
            defer { self?.task = nil }
            do {
                try await self?.asyncTask()
            } catch {
                print("[HEY]", "Task error: \(error)")
            }
        }
    }

    private func asyncTask() async throws {
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
                await viewModel.processAsync()
            }
            .onAppear() {
                viewModel.runTask()
            }
    }
}
