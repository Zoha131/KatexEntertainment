//
//  PopularMovieView.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI
import Kingfisher

struct PopularMovieView: View {
    let movie: Movie

    var body: some View {
        VStack {
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
                .frame(maxWidth: .infinity, minHeight: 125)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(movie.title)
                .foregroundColor(.white)
                .font(.system(size: 16))

            Text(movie.genres)
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
    }
}

//struct PopularMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            HStack(spacing: 32) {
//                PopularMovieView()
//
//                PopularMovieView()
//            }
//            .padding(.horizontal, 32)
//
//            Spacer()
//        }
//        .background(Color.background)
//    }
//}
