//
//  MovieDetailsView.swift
//  TrendyMovies
//
//  Created by Abdalrahman Shatou on 03/07/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    private let screenSize = UIScreen.main.bounds.size
    
    let movie: Movie
    
    var body: some View {
        NavigationView {
            ScrollView {
                AsyncImage(url: movie.posterPath.url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenSize.width, height: screenSize.width * 14 / 9.0)
                        .clipped()
                } placeholder: {
                    VStack {
                        ProgressView {
                            Text("Loading poster...")
                        }
                    }
                    .frame(width: screenSize.width, height: screenSize.width * 14 / 9.0)
                }
                
                VStack(alignment: .leading, content: {
                    Text(movie.title)
                        .font(.system(.title2))
                        .fontWeight(.black)
                    
                    Text(movie.year)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Text(movie.overview)
                        .font(.system(.body))
                        .padding(.top, 8)
                    
                    Spacer()
                })
                .padding(16)
            }
           
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.thinMaterial, for: .navigationBar)
    }
 }

