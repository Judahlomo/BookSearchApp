# BookSearchApp

BookSearchApp is a SwiftUI iOS application that allows users to search for books using the Open Library API, view details about them, and save favorites locally using Core Data.

## Features

- Search for books by title or keyword
- View book details including title, authors, publisher, and cover image
- Save books to a local favorites list
- View and remove favorite books
- Built with MVVM architecture, Core Data, and Combine

## Architecture

The app follows the Model-View-ViewModel (MVVM) pattern. Key components include:

- Models/
  - Book.swift: Decodable model for Open Library books
- Views/
  - BookSearchView.swift: Main UI for searching books
  - BookDetailView.swift: Shows details and allows saving to favorites
  - FavoritesView.swift: Displays list of saved books
- Services/
  - BookAPIService.swift: Handles all network requests to Open Library API
  - CoreDataManager.swift: Handles saving, fetching, and deleting favorites from Core Data
- BookSearchApp.xcdatamodeld: Core Data model containing the FavoriteBook entity

## Screenshots

<img width="369" alt="Screenshot 2025-03-31 at 1 14 22 PM" src="https://github.com/user-attachments/assets/47a0530b-ca16-4daf-8561-64e04fb20f0d" />
<img width="369" alt="Screenshot 2025-03-31 at 1 13 49 PM" src="https://github.com/user-attachments/assets/8021657d-60f7-4533-872c-3dec0cc666b4" />
<img width="369" alt="Screenshot 2025-03-31 at 3 12 51 PM" src="https://github.com/user-attachments/assets/3ee77a91-8462-4279-8888-2c518abd9450" />


## API Used

Open Library Search API  
https://openlibrary.org/dev/docs/api/search  
Example endpoint:  
https://openlibrary.org/search.json?q=harry+potter

## How to Run

1. Clone the repository
2. Open BookSearchApp.xcodeproj in Xcode
3. Build and run on a simulator or device
4. Type in a search term to find books
5. Tap on a book to view details
6. Save to favorites, and view them in the Favorites tab

## Requirements

- iOS 15.0+
- Xcode 14 or higher
- Swift 5+

## Author

Judah Lomo
