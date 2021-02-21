//
//  Genre.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 18.02.2021.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int
    let name: String
}
