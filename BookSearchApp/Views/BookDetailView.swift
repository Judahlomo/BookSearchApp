//
//  BookDetailView.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    @State private var isFavorited = false

    var body: some View {
        VStack(spacing: 20) {
            if let url = book.coverURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 150, height: 225)
                .cornerRadius(10)
            }

            Text(book.title)
                .font(.title)
                .multilineTextAlignment(.center)

            Text("By: \(book.authors.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("Publisher: \(book.publisher)")
                .font(.subheadline)

            Button(action: {
                CoreDataManager.shared.addFavorite(from: book)
                isFavorited = true
            }) {
                Label(isFavorited ? "Saved!" : "Save to Favorites", systemImage: "star.fill")
            }
            .buttonStyle(.borderedProminent)
            .disabled(isFavorited)
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isFavorited = CoreDataManager.shared.isBookFavorited(book)
        }
    }
}
