//
//  ExploreScreen.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI

protocol ExploreScreenDelegate: AnyObject {
    func onItemTap(movie: Movie)
}

struct ExploreScreen: View {
    @StateObject var viewModel = ExploreViewModel()
    @FocusState var searchFieldIsFocused: Bool
    weak var delegate: ExploreScreenDelegate?

    var body: some View {
        VStack {
            HStack(spacing: 29) {
                HStack(spacing: 23) {
                    Image("search")
                    TextField("Search", text: $viewModel.query)
                        .onSubmit {
                            if viewModel.query.count > 0 {
                                Task {
                                    await viewModel.searchMovies()
                                }
                            }

                            searchFieldIsFocused = false
                        }
                        .submitLabel(.search)
                }
                .focused($searchFieldIsFocused)
                .padding()
                .background(Color.cardBackground)
                .clipShape(Capsule())


                if case .uninitialized = viewModel.state.searchMovies {

                } else {
                    Button("Cancel"){
                        searchFieldIsFocused = false
                        viewModel.clearQuery()
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
                    if case .uninitialized = viewModel.state.searchMovies {
                        if searchFieldIsFocused {
                            ForEach(0..<5) { movie in
                                HistoryMovieView()
                                    .onTapGesture {
                                        //delegate?.onItemTap(movie: movie)
                                    }
                            }
                            .padding(.horizontal, 32)
                            .padding(.bottom, 15)
                        }

                        HStack {
                            Text("Popular")
                                .font(.system(size: 20))

                            Spacer()

                            Button {

                            } label: {
                                Text("See all")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                            }

                        }
                        .padding(.horizontal, 32)

                        PopularExploreView(
                            popularMovies: viewModel.state.popularMovies,
                            loadPopularMovies: { viewModel.loadPopularMovies() },
                            delegate: delegate
                        )
                    } else {
                        SearchExploreView(
                            movies: viewModel.state.searchMovies,
                            searchMovies: {
                                Task {
                                    await viewModel.searchMovies()
                                }
                            },
                            query: viewModel.query,
                            delegate: delegate
                        )
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

private struct PopularExploreView: View {
    let popularMovies: Async<[Movie]>
    let loadPopularMovies: () -> ()
    weak var delegate: ExploreScreenDelegate?

    var body: some View {
        switch popularMovies {
        case .success(let movies):
            HStack(alignment: .top, spacing: 32) {
                LazyVStack {
                    let indices = movies.indices.compactMap { index in
                        index % 2 == 0 ? index : nil
                    }

                    ForEach(indices, id: \.self) { index in
                        PopularMovieView(movie: movies[index])
                            .onTapGesture {
                                delegate?.onItemTap(movie: movies[index])
                            }
                    }
                    .padding(.bottom, 15)
                }

                LazyVStack {
                    let indices = movies.indices.compactMap { index in
                        index % 2 == 1 ? index : nil
                    }

                    ForEach(indices, id: \.self) { index in
                        PopularMovieView(movie: movies[index])
                            .onTapGesture {
                                delegate?.onItemTap(movie: movies[index])
                            }
                    }
                    .padding(.bottom, 15)
                }
            }
            .padding(.horizontal, 32)
        case .failed(_, _ ) :
            HStack {
                Text("Failed to load")

                Button("Try Again"){
                    loadPopularMovies()
                }
            }
        default:
            ProgressView()
        }
    }
}

private struct SearchExploreView: View {
    let movies: Async<[Movie]>
    let searchMovies: () -> ()
    let query: String
    weak var delegate: ExploreScreenDelegate?

    var body: some View {
        switch movies {
        case .success(let movies):
            if movies.isEmpty {
                Text("No result found. Try another text")
            } else {
                ForEach(movies) { movie in
                    SearchMovieView(movie: movie, query: query)
                        .onTapGesture {
                            delegate?.onItemTap(movie: movie)
                        }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 15)
            }
        case .failed(_, _ ) :
            HStack {
                Text("Failed to search")

                Button("Try Again"){
                    searchMovies()
                }
            }
        default:
            ProgressView()
        }
    }
}
