//
//  MenuView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/12/25.
//

import SwiftUI

enum MenuOption {
    case simpleImage
    case observation
    case webView
    case bottomSheet
    
    var title: String {
        switch self {
        case .simpleImage: "Image view"
        case .observation: "Observation"
        case .webView: "Web View"
        case .bottomSheet: "Bottom Sheet"
        }
    }
    
    var description: String {
        switch self {
        case .simpleImage: "Shows a simple image view"
        case .observation: "Observation framework example"
        case .webView: "WebView framework example"
        case .bottomSheet: "Bottom sheet example"
        }
    }
    
    @ViewBuilder
    @MainActor
    var view: some View {
        switch self {
        case .simpleImage: ImageView()
        case .observation: NumberView()
        case .webView: DemoWebView()
        case .bottomSheet: BottomSheetView()
        }
    }
}

extension MenuOption: Hashable {
    static func == (lhs: MenuOption, rhs: MenuOption) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct MenuView: View {
    let options: [MenuOption] = [
        .simpleImage,
        .observation,
        .webView,
        .bottomSheet,
    ]
    
    @State var path: [MenuOption] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List(options, id:\.self) { option in
                NavigationLink(value: option) {
                    MenuRowView(
                        title: option.title,
                        description: option.description
                    )
                }
            }
            .navigationDestination(for: MenuOption.self) {
                $0.view
            }
        }
    }
}

private struct MenuRowView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
            Text(description)
                .font(.caption)
        }
    }
}
