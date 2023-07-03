//
//  MoviesListViewModel.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import Combine
import Factory

protocol MoviesListViewModelProtocol {
    var input: MoviesListViewModel.Input { get }
    var output: MoviesListViewModel.Output { get }
}

final class MoviesListViewModel: ViewModel, MoviesListViewModelProtocol, ViewModelType {
    
    enum Route {
        case pushMovieDetails(movieId: String)
    }
    
    class Input: ObservableObject {
        let viewAppearedTrigger: AnyUIEvent<Void> = .create()
        let getMoreMoviesTrigger: AnyUIEvent<Void> = .create()
        let movieImpressionTrigger: AnyUIEvent<Movie> = .create()
        let fetchMoviesTrigger: AnyUIEvent<Void> = .create()
    }
    
    class Output: ObservableObject {
        @Published fileprivate(set) var movies: [Movie] = []
        @Published fileprivate(set) var isFetchingMovies: Bool = false
        @Published fileprivate(set) var errorMessage: String?
        @Published fileprivate(set) var route: Route?
        
        init() {
        }
    }
    
    let input: Input
    let output: Output
    
    @Injected(\.moviesListRepository) private var moviesListRepository: MoviesListRepositoryProtocol
    
    override init() {
        input = .init()
        output = .init()
        
        super.init()
        
        observeViewAppearedTrigger()
        observeGetMoreMoviesTrigger()
        observeMovieImpressionTrigger()
        observeFetchMoviesTrigger()
    }
}

// MARK: - Observers
extension MoviesListViewModel {
    
    private func observeViewAppearedTrigger() {
        input
            .viewAppearedTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.fetchMovies()
            }
            .store(in: &cancellables)
    }
    
    private func observeGetMoreMoviesTrigger() {
        input
            .getMoreMoviesTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.fetchMovies()
            }
            .store(in: &cancellables)
    }
    
    private func observeMovieImpressionTrigger() {
        input
            .movieImpressionTrigger
            .sink { [weak self] movie in
                guard
                    let self,
                    let indexOfMovie = self.output.movies.firstIndex(where: { aMovie in
                        return aMovie.id == movie.id
                    }),
                    indexOfMovie >= self.output.movies.count - 4
                else {
                    return
                }
                
                self.fetchMovies()
            }
            .store(in: &cancellables)
    }
    
    private func observeFetchMoviesTrigger() {
        input
            .fetchMoviesTrigger
            .sink { [weak self] in
                guard let self else { return }
                self.fetchMovies()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - Networking
extension MoviesListViewModel {
    
    private func fetchMovies() {
        if self.output.isFetchingMovies { return }
        
        Task { @MainActor in
            defer {
                self.output.isFetchingMovies = false;
            }
            
            self.output.isFetchingMovies = true;
            self.output.errorMessage = nil;
            
            do {
                let moviesList = try await self.moviesListRepository.getMoviesList()
                self.output.movies.append(contentsOf: moviesList)
            } catch {
                self.output.errorMessage = "An error occurred fetching the list of movies"
            }
        }
    }
}
