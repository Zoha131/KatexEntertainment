//
//  PopularMovieView.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI

struct PopularMovieView: View {
    var body: some View {
        VStack {
            ZStack {

            }
            .frame(maxWidth: .infinity, maxHeight: 85)
            .background(Color.pink)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("Wonder Woman")
                .foregroundColor(.white)
                .font(.system(size: 16))

            Text("Comedy, Family")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
    }
}

struct PopularMovieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack(spacing: 32) {
                PopularMovieView()

                PopularMovieView()
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .background(Color.background)
    }
}
