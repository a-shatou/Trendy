//
//  MoviesListRepository.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import Foundation
import Factory
import CoreData

protocol MoviesListRepositoryProtocol {
    @MainActor func getMoviesList() async throws
}

final class MoviesListRepository: MoviesListRepositoryProtocol {
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    
    @MainActor func getMoviesList() async throws {
        
    }
    
}
