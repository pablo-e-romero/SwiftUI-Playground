//
//  BroadcastStream.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/10/25.
//

import Foundation

final class BroadcastStream<Element: Sendable>: @unchecked Sendable {
    private var continuations = [UUID: AsyncStream<Element>.Continuation]()
    private let lock = NSLock()

    func makeStream() -> AsyncStream<Element> {
        AsyncStream { continuation in
            let id = addContinuation(continuation)
            
            continuation.onTermination = { [weak self] _ in
                Task { await self?.removeContinuation(with: id) }
            }
        }
    }
    
    func yield(_ element: Element) {
        lock.lock()
        continuations.values.forEach { $0.yield(element) }
        lock.unlock()
    }
    
    private func removeContinuation(with id: UUID) {
        lock.lock()
        continuations[id] = nil
        lock.unlock()
    }
    
    private func addContinuation(_ continuation: AsyncStream<Element>.Continuation) -> UUID {
        let id = UUID()
        lock.lock()
        continuations[id] = continuation
        lock.unlock()
        return id
    }
}
