//
//  BookSearchAppApp.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/30/25.
//

import SwiftUI

@main
struct BookSearchAppApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
