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
        let viewDidAppearTrigger: AnyUIEvent<Void> = .create()
        
    }
    
    class Output: ObservableObject {
        @Published fileprivate(set) var movies: [Movie]?
        @Published fileprivate(set) var isFetchingMovies: Bool = false
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
        
        prepareState()
        
        observeViewDidAppearTrigger()
    }
    
    private func prepareState() {
        Task { @MainActor in
            
        }
    }
}

// MARK: - Observers
extension MoviesListViewModel {
    
    private func observeViewDidAppearTrigger() {
        input
            .viewDidAppearTrigger
            .sink { [weak self] in
                guard let self else { return }
            }
            .store(in: &cancellables)
    }
}
