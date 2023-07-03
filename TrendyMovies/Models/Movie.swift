//
//  Movie.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import AutoChangeable

struct Movie: AutoChangeable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let year: String
}

extension Movie: Changeable {
    init(copy: ChangeableWrapper<Self>) {
        self.init(
            id: copy.id,
            title: copy.title,
            posterPath: copy.posterPath,
            overview: copy.overview,
            year: copy.year
        )
    }
}

extension Movie {
    
    static let stub: Movie = {
        return .init(id: 0, title: "", posterPath: "", overview: "", year: "")
    }()
    
}
