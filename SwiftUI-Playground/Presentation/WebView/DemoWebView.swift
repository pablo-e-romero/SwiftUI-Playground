//
//  DemoWebView.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 11/12/25.
//

import SwiftUI
import WebKit

@Observable
final class DemoWebViewModel {
    private(set) var stateDescription: String = "idle"
    private(set) var page: WebPage
    private let url = URL(string: "https://google.com")!
    
    init() {
        self.page = WebPage()
    }
    
    func load() async {
        stateDescription = "requesting"
        var request = URLRequest(url: url)
        request.attribution = .developer
        let events = page.load(request)
        
        do {
            for try await event in events {
                stateDescription = "\(event)"
            }
        } catch {
            stateDescription = error.localizedDescription
        }
    }
}

struct DemoWebView: View {
    @State private var viewModel = DemoWebViewModel()
    @State private var toggle = false
    
    var body: some View {
        VStack {
            Group {
                ZStack {
                    toggle ? Color.red : Color.green
                    Text(viewModel.stateDescription)
                }
            }
            .frame(height: 100)
            
            WebView(viewModel.page)
                .navigationTitle(viewModel.page.title)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Toggle("Switch", isOn: $toggle)
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    DemoWebView()
}
