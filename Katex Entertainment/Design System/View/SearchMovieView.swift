//
//  SearchMovieView.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI
import Kingfisher

struct SearchMovieView: View {
    private let movie: Movie
    private let query: String
    private let attributedTitle: AttributedString

    init(movie: Movie, query: String){
        self.movie = movie
        self.query = query

        var attributedTitle = AttributedString(movie.title)

        if let range = attributedTitle.range(of: query, options: [.caseInsensitive]) {
            attributedTitle[range].foregroundColor = .highlight
        }

        self.attributedTitle = attributedTitle
    }

    var body: some View {
        HStack(spacing: 20) {

            KFImage
                .url(URL(string: movie.image))
                .placeholder {
                    Image("placeholder")
                        .resizable()
                        .opacity(0.3)
                }
                .fade(duration: 0.25)
                .resizable()
                .scaledToFill()
                .frame(width: 148, height: 190)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay {
                    LinearGradient(
                        colors: [.clear, .clear, .background.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }

            VStack(alignment: .leading, spacing: 8) {
                Text(attributedTitle)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .lineLimit(2)

                Text("\(movie.year) | \(movie.genres)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 14))

                    Text(movie.iMDBRating ?? "0.0")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }

                Button {

                } label: {
                    Text("Watch Now")
                        .frame(maxWidth: .infinity, maxHeight: 43)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.top)

            }
        }
    }
}

//struct SearchMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            SearchMovieView(title: "Captain Marvel", query: "Marvel")
//                .padding(.horizontal, 32)
//
//            Spacer()
//        }
//        .background(Color.background)
//    }
//}
