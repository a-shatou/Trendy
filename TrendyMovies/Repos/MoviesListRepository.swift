//
//  MoviesListRepository.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import Factory
import CoreData
import Combine

protocol MoviesListRepositoryProtocol {
    @MainActor func getMoviesList() async throws -> [Movie]
}

final class MoviesListRepository: MoviesListRepositoryProtocol {
    private var currentPage = 0
    
    @MainActor func getMoviesList() async throws -> [Movie] {
        self.currentPage += 1
        let session = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(self.currentPage)&sort_by=popularity.desc")!
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0OGY3ZmIyNDYxMGYwYjlmZGIyMzJmNmNhYTY0NGYzYiIsInN1YiI6IjY0YTMwOTQ1OGUyMGM1MDBjYmVjMjRhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.INBgXvbmn2evTshv_MYAEfegUagzHicc3m5L8NRKIfE", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let moviesListResponseDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let moviesListDict = moviesListResponseDict?["results"] as? [[String: Any]]
        var moviesList: [Movie] = []
        moviesListDict?.forEach { resultDict in
            let movie = Movie(
                id: resultDict["id"] as? Int ?? 0,
                title: resultDict["title"] as? String ?? "",
                posterPath: "https://image.tmdb.org/t/p/w500\(resultDict["poster_path"] as? String ?? "")",
                overview: resultDict["overview"] as? String ?? "",
                year: (resultDict["release_date"] as? String ?? "").substring(to: 4))
            moviesList.append(movie)
        }
        return moviesList
    }
}
