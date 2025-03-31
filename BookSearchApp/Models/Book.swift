//
//  Book.swift
//  BookSearchApp
//
//  Created by Judah Lomo on 3/31/25.
//

import Foundation

struct Book: Identifiable, Decodable {
    let id: String
    let title: String
    let authors: [String]
    let publisher: String
    let coverURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case authors = "author_name"
        case publisher = "publisher"
        case coverID = "cover_i"
    }

    // Custom decoding to transform API fields
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // ID comes as "/works/OL12345W", we only want the final part or full as unique identifier
        let rawID = try container.decode(String.self, forKey: .id)
        self.id = rawID

        self.title = try container.decode(String.self, forKey: .title)
        self.authors = try container.decodeIfPresent([String].self, forKey: .authors) ?? ["Unknown"]
        self.publisher = try container.decodeIfPresent([String].self, forKey: .publisher)?.first ?? "Unknown"

        if let coverID = try container.decodeIfPresent(Int.self, forKey: .coverID) {
            self.coverURL = URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg")
        } else {
            self.coverURL = nil
        }
    }
}
