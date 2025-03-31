//
//  ContentView.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BookSearchView()
                .tabItem {
                    Label("Search", systemImage: "book")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
