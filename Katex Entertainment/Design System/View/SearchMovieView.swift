//
//  SearchMovieView.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI

struct SearchMovieView: View {
    private let attributedTitle: AttributedString
    private let query: String

    init(title: String, query: String){
        self.query = query

        var attributedTitle = AttributedString(title)

        if let range = attributedTitle.range(of: query) {
            attributedTitle[range].foregroundColor = .highlight
        }

        self.attributedTitle = attributedTitle
    }

    var body: some View {
        HStack(spacing: 20) {

            ZStack {


            }
            .frame(width: 148, height: 190)
            .background(Color.pink)
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
                    .lineLimit(1)

                Text("2019 | Action, Fantasy")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 14))

                    Text("6.5")
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

struct SearchMovieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchMovieView(title: "Captain Marvel", query: "Marvel")
                .padding(.horizontal, 32)

            Spacer()
        }
        .background(Color.background)
    }
}
