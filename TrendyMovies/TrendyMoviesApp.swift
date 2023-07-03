//
//  TrendyMoviesApp.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import SwiftUI

@main
struct TrendyMoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
