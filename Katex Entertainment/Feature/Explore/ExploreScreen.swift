//
//  ExploreScreen.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI

protocol ExploreScreenDelegate {

}

struct ExploreScreen: View {
    @StateObject var viewModel = ExploreViewModel()
    @FocusState var searchFieldIsFocused: Bool

    var body: some View {
        VStack {
            HStack(spacing: 29) {
                HStack(spacing: 23) {
                    Image("search")
                    TextField("Search", text: $viewModel.query)
                }
                .focused($searchFieldIsFocused)
                .padding()
                .background(Color.cardBackground)
                .clipShape(Capsule())


                if searchFieldIsFocused {
                    Button("Cancel"){
                        searchFieldIsFocused = false
                        viewModel.query = ""
                    }
                    .transition(.opacity)
                    .foregroundColor(.label)
                }
            }
            .animation(.easeInOut, value: searchFieldIsFocused)
            .padding(.horizontal, 37)
            .padding(.vertical, 19)

            ScrollView {
                LazyVStack {
                    switch viewModel.state.popularMovies {
                    case .success(let movies):
                        HStack(alignment: .top, spacing: 32) {
                            LazyVStack {
                                let indices = movies.indices.compactMap { index in
                                    index % 2 == 0 ? index : nil
                                }

                                ForEach(indices, id: \.self) { index in
                                    PopularMovieView(movie: movies[index])
                                }
                            }

                            LazyVStack {
                                let indices = movies.indices.compactMap { index in
                                    index % 2 == 1 ? index : nil
                                }

                                ForEach(indices, id: \.self) { index in
                                    PopularMovieView(movie: movies[index])
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                    default:
                        ProgressView()
                    }
                }
            }
        }
        .background(Color.background)
        .onAppear {
            viewModel.loadPopularMovies()
        }
    }
}

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
    }
}
