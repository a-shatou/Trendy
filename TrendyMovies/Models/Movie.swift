//
//  Movie.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import AutoChangeable

struct Movie: AutoChangeable {
    let name: String
}

extension Movie: Changeable {
    init(copy: ChangeableWrapper<Self>) {
        self.init(
            name: copy.name
        )
    }
}

extension Movie {
    
    static let stub: Movie = {
        return .init(name: "")
    }()
    
}
