//
//  ContentView.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import SwiftUI

struct MoviesListView: View {
    
    private let screenSize = UIScreen.main.bounds.size
    
    @StateObject private var input: MoviesListViewModel.Input
    @StateObject private var output: MoviesListViewModel.Output
    
    init(viewModel: MoviesListViewModelProtocol) {
        _input = .init(wrappedValue: viewModel.input)
        _output = .init(wrappedValue: viewModel.output)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    makeProgressView()
                    
                    makeMovieListView()
                    
                    
                    // Shall show pagination view
                }
            }
            .navigationTitle("Trending Movies")
            .onFirstAppear {
                input.viewAppearedTrigger.send()
            }
        }
    }
    
    private func makeProgressView() -> some View {
        return ProgressView {
            Text("Loading trending movies...")
        }
        .padding(.top, 24)
        .isHidden(!output.isFetchingMovies && !output.movies.isEmpty, remove: true)
    }
    
    private func makeMovieListView() -> some View {
        return ForEach(output.movies, id: \.id) { movie in
            makeMovieRowView(movie: movie)
        }
    }
    
    private func makeMovieRowView(movie: Movie) -> some View {
        return NavigationLink {
            MovieDetailsView()
        } label: {
            HStack(alignment: .top, spacing: 8) {
                AsyncImage(url: movie.posterPath.url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenSize.width / 4)
                } placeholder: {
                    Image(systemName: "popcorn.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenSize.width / 4)
                }
                .cornerRadius(5)
                .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(movie.title)
                        .fontWeight(.bold)
                        .font(.system(.title3))
                    
                    Text(movie.year)
                        .font(.system(.body, design: .rounded))
                    
                    Spacer()
                    
                    Text(movie.overview)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                        .font(.system(.caption))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .buttonStyle(PlainButtonStyle())
    }
    
}
