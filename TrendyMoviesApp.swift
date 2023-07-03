//
//  TrendyMoviesApp.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import SwiftUI

@main
struct TrendyMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesListView(viewModel: MoviesListViewModel())
        }
    }
}
