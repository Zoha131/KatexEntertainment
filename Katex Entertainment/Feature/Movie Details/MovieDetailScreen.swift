//
//  MovieDetailScreen.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI
import Kingfisher

struct MovieDetailScreen: View {
    let imageUrl = "https://imdb-api.com/images/original/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_Ratio0.6837_AL_.jpg"

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    GeometryReader { reader in
                        let global = reader.frame(in: .global)

                        KFImage
                            .url(URL(string: imageUrl))
                            .placeholder {
                                Image("placeholder").opacity(0.3)
                            }
                            .fade(duration: 0.25)
                            .resizable()
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.width + max(0, global.minY), alignment: .center)
                            .clipped()
                            .overlay {
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        .background
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                            .offset(y: global.minY > 0 ? -global.minY : global.minY)
                    }
                    .frame(height: UIScreen.main.bounds.width - 100)
                    

                    VStack(alignment: .center, spacing: 12) {
                        Text("Captain Marvel")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .fontWeight(.medium)

                        Text("2019 | Action, Fantasy | 2h 34min")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
                            .fontWeight(.heavy)

                        HStack {
                            Text("4.5")
                                .foregroundColor(.white)

                            if let rating = Double("4.5"), let ratingInt = Int(rating) {
                                let ratingEnd = rating > Double(ratingInt) ? ratingInt + 1 : ratingInt

                                ForEach(0..<ratingEnd) { star in
                                    Image(systemName: star < ratingInt ? "star.fill" : "star.leadinghalf.filled")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .font(.system(size: 14))
                    }
                    .frame(maxWidth: .infinity)

                    Text("Distributed by Walt Disney Studios Motion Pictures, it is the 21st film in the Marvel Cinematic Universe (MCU).")
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 32)
                        .padding(.vertical)


                    Section {

                        HStack(spacing: -15) {

                            ZStack {

                            }
                            .frame(width: 44, height: 44)
                            .background(Color.green)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))

                            ZStack {

                            }
                            .frame(width: 44, height: 44)
                            .background(Color.red)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))

                            ZStack {

                            }
                            .frame(width: 44, height: 44)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))

                            ZStack {

                            }
                            .frame(width: 44, height: 44)
                            .background(Color.yellow)
                            .overlay {
                                ZStack {
                                    Color.background
                                        .opacity(0.8)

                                    Text("6+")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                }
                            }
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))

                        }

                    } header: {
                        Text("Cast")
                            .font(.system(size: 20))
                            .foregroundColor(.white)

                    }
                    .padding(.horizontal, 32)

                }
            }

            VStack {
                HStack {
                    Button {

                    } label: {
                        Image(systemName: "chevron.left")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 14, height: 24)

                    }

                    Spacer()

                    Button {

                    } label: {
                        Image("download")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 14, height: 24)

                    }
                }
                .padding(.horizontal, 32)
                .padding(.vertical)

                Spacer()
            }

            HStack(spacing: 18) {
                Button {

                } label: {
                    Image("favorite")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 38, height: 38)


                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
                .cornerRadius(20)

                Button {

                } label: {
                    Text("Watch Now")
                        .foregroundColor(.white)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(20)
            }
            .padding(.horizontal, 32)
            .padding(.vertical)
            .background(Color.background)
        }
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen()
            .background(Color.background)
    }
}
