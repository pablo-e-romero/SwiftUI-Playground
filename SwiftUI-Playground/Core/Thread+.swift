//
//  Thread+.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 12/12/25.
//

import Foundation

extension Thread {
    nonisolated static var currentThread: Thread {
        Self.current
    }
}
