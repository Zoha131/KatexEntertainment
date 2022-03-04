//
//  HistoryMovieView.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI

struct HistoryMovieView: View {
    var body: some View {
        HStack(spacing: 16) {
            ZStack {

            }
            .frame(width: 74, height: 82)
            .background(Color.pink)
            .clipShape(RoundedRectangle(cornerRadius: 10))


            VStack(alignment: .leading, spacing: 4) {
                Text("Captain America")
                    .foregroundColor(.white)
                    .font(.system(size: 16))

                Text("2019 | Action, Fantasy")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 14))

                    Text("6.5")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                }
            }

            Spacer()

            Button {

            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }

        }
    }
}

struct HistoryMovieView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HistoryMovieView()
                .padding(.horizontal, 32)
            Spacer()

            HStack {
                Spacer()
            }
        }
        .background(Color.background)
    }
}
