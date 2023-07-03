//
//  RepositoryContainer.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import Factory

extension Container {
    var moviesListRepository: Factory<MoviesListRepositoryProtocol> {
        Factory(self) { MoviesListRepository() }
    }
}
