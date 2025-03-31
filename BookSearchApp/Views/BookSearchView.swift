//
//  BookSearchView.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import SwiftUI

struct BookSearchView: View {
    @StateObject private var viewModel = BookSearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search books...", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.books.isEmpty {
                    Text("No results yet.")
                        .foregroundColor(.gray)
                } else {
                    List(viewModel.books) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            HStack {
                                if let url = book.coverURL {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 75)
                                    .cornerRadius(5)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 50, height: 75)
                                        .cornerRadius(5)
                                }

                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                    Text(book.authors.joined(separator: ", "))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Book Search")
        }
    }
}
