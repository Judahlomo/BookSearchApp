//
//  CoreDataManager.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "BookSearchApp") // Update this if your .xcdatamodeld file is named differently
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading Core Data store: \(error)")
            } else {
                print("✅ Core Data store loaded successfully")
            }
        }
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("💾 Context saved successfully")
            } catch {
                print("❌ Error saving context: \(error)")
            }
        }
    }

    func addFavorite(from book: Book) {
        guard !isBookFavorited(book) else {
            print("⚠️ Book already favorited: \(book.title)")
            return
        }

        let favorite = FavoriteBook(context: context)
        favorite.id = book.id
        favorite.title = book.title
        favorite.authors = book.authors.joined(separator: ", ")
        favorite.publisher = book.publisher
        favorite.coverURL = book.coverURL?.absoluteString
        print("✅ Adding favorite: \(book.title)")
        saveContext()
    }

    func removeFavorite(_ favorite: FavoriteBook) {
        print("🗑 Removing favorite: \(favorite.title ?? "Unknown")")
        context.delete(favorite)
        saveContext()
    }

    func isBookFavorited(_ book: Book) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", book.id)

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("❌ Error checking favorite status: \(error)")
            return false
        }
    }

    func fetchFavorites() -> [FavoriteBook] {
        let request: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
        do {
            let favorites = try context.fetch(request)
            print("📚 Fetched \(favorites.count) favorites")
            return favorites
        } catch {
            print("❌ Error fetching favorites: \(error)")
            return []
        }
    }
}
