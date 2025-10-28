//
//  Observable+.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 28/10/25.
//

import Observation

extension Observable {
    func makeStream<Value: Sendable>(
        of keyPath: KeyPath<Self, Value>
    ) -> any AsyncSequence<Value, Never> {
        Observations { [keyPath] in
            self[keyPath: keyPath]
        }
    }
}
