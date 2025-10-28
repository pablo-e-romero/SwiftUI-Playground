//
//  Emitter.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 28/10/25.
//

import Observation

@MainActor
@Observable
final class Emitter {
    var value: String?
    
    @ObservationIgnored
    static let shared = Emitter()
    
    @ObservationIgnored
    private var task: Task<Void, Never>?
    
    private init() {
        emit()
    }
    
    deinit {
        task?.cancel()
    }
    
    func emit() {
        task = Task { [weak self] in
            for value in 1...1000 {
                try? await Task.sleep(for: .seconds(1))
                self?.value = "\(value)"
            }
        }
    }
}
