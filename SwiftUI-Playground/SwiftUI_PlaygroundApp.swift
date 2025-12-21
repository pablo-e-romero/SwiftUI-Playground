//
//  SwiftUI_PlaygroundApp.swift
//  SwiftUI-Playground
//
//  Created by Pablo Ezequiel Romero Giovannoni on 06/08/2023.
//

import SwiftUI

@main
struct SwiftUI_PlaygroundApp: App {
   var body: some Scene {
        WindowGroup {
            TabView {
                PushView()
                    .tabItem {
                        Label("Async Sequence", systemImage: "clock")
                    }
                
                MenuView()
                    .tabItem {
                        Label("More", systemImage: "ellipsis")
                    }
            }
        }
    }
}
