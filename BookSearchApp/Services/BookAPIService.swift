//
//  BookAPIService.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import Foundation

class BookAPIService {
    static let shared = BookAPIService()
    private let baseURL = "https://openlibrary.org/search.json"

    func searchBooks(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?q=\(encodedQuery)") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.noData))
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(OpenLibraryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse.docs))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    enum APIError: Error {
        case invalidURL
        case noData
    }
}

// Wrapper for the API's root JSON structure
struct OpenLibraryResponse: Decodable {
    let docs: [Book]
}
