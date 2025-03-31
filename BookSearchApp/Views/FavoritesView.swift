//
//  FavoritesView.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import SwiftUI

struct FavoritesView: View {
    @FetchRequest(
        entity: FavoriteBook.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteBook.title, ascending: true)]
    ) var favorites: FetchedResults<FavoriteBook>

    var body: some View {
        NavigationView {
            if favorites.isEmpty {
                VStack {
                    Spacer()
                    Text("No favorites yet.")
                        .foregroundColor(.gray)
                        .font(.headline)
                    Spacer()
                }
            } else {
                List {
                    ForEach(favorites) { book in
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.authors ?? "Unknown Author")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteFavorite)
                }
            }
        }
        .navigationTitle("Favorites")
    }

    private func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let book = favorites[index]
            CoreDataManager.shared.removeFavorite(book)
        }
    }
}
