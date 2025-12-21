//
//  Emitter.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 28/10/25.
//

import Foundation

@MainActor
final class Emitter {
    static let shared = Emitter()
    
    private let broadcast = BroadcastStream<String>()
    private var task: Task<Void, Never>?
    
    private init() {
        start()
    }
    
    deinit {
        task?.cancel()
    }
    
    func makeStream() -> some AsyncSequence<String, Never> {
        broadcast.makeStream()
    }
    
    private func start() {
        task = Task { [weak self] in
            for value in 1...1000 {
                try? await Task.sleep(for: .seconds(1))
                self?.broadcast.yield("\(value)")
            }
        }
    }
}
