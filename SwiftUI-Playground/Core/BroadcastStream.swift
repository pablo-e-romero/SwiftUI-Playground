//
//  BroadcastStream.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/10/25.
//

import Foundation
import Synchronization

final class BroadcastStream<Element: Sendable>: Sendable {
    private let continuations: Mutex<[UUID: AsyncStream<Element>.Continuation]> = .init([:])

    func makeStream() -> AsyncStream<Element> {
        AsyncStream { continuation in
            let id = continuations.withLock { continuations in
                let id = UUID()
                continuations[id] = continuation
                return id
            }
            
            continuation.onTermination = { [weak self] _ in
                self?.continuations.withLock { continuations in
                    continuations[id] = nil
                }
            }
        }
    }
    
    func yield(_ element: Element) {
        continuations.withLock { continuations in
            continuations.values.forEach { $0.yield(element) }
        }
    }
    
    private func addContinuation(_ continuation: AsyncStream<Element>.Continuation) -> UUID {
        continuations.withLock { continuations in
            let id = UUID()
            continuations[id] = continuation
            return id
        }
    }
}
