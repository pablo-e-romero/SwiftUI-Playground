//
//  AsyncSequence+Debounce.swift
//  SwiftUI-Playground
//
//  Created by Pablo Romero on 13/12/25.
//

import SwiftUI

//@Observable
//final class SearchViewModel {
//    private let allBooks = [
//        "Harry Potter",
//        "The Bible",
//        "Jurasic Park",
//        "Hunger Games"
//    ]
//    
//    var query = "" {
//        willSet {
//            continuation.yield(newValue)
//        }
//    }
//    
//    var filteredBooks: [String]
//    
//    private let (stream, continuation) = AsyncStream.makeStream(of: String.self)
//    
//    init() {
//        
//        self.filteredBooks = allBooks
//        
//        Task {
//            for await newQuery in stream.debounce(for: .milliseconds(330)) {
//                guard !newQuery.isEmpty else {
//                    filteredBooks = allBooks
//                    continue
//                }
//            }
//            
//            filteredBooks = allBooks.filter { book in
//                book.lowercased.containsnewQuery.lowercased()
//            }
//        }
//    }
//}
//
//struct AsyncSequence_Debounce: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    AsyncSequence_Debounce()
//}
