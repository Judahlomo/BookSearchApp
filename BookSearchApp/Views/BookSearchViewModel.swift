//
//  BookSearchView.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import Foundation
import Combine

class BookSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                self?.searchBooks(query: newQuery)
            }
            .store(in: &cancellables)
    }

    func searchBooks(query: String) {
        guard !query.isEmpty else {
            books = []
            return
        }

        isLoading = true
        errorMessage = nil

        BookAPIService.shared.searchBooks(query: query) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
