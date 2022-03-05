//
//  MovieDetailScreen.swift
//  Katex Entertainment
//
//  Created by MD Abir Hasan Zoha on 3/4/22.
//

import SwiftUI
import Kingfisher

protocol MovieDetailScreenDelegate: AnyObject {
    func onBackTap()
}

struct MovieDetailScreen: View {
    let movie: Movie
    @StateObject var viewModel = MovieDetailViewModel()
    weak var delegate: MovieDetailScreenDelegate?

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 12) {
                    GeometryReader { reader in
                        let global = reader.frame(in: .global)

                        KFImage
                            .url(URL(string: movie.image))
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
                    

                    switch viewModel.state.detail {
                    case .success(let movieDetail):
                        MovieDetailView(movieDetail: movieDetail)
                            .padding(.bottom, 200)
                    case .failed(_, _ ) :
                        HStack {
                            Text("Failed to load")

                            Button("Try Again"){
                                Task {
                                    await viewModel.loadDetail(of: movie.id)
                                }
                            }
                        }
                    default:
                        ProgressView()
                            .tint(.accent)
                    }
                }
            }

            VStack {
                HStack {
                    Button {
                        delegate?.onBackTap()
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
        .task {
            await viewModel.loadDetail(of: movie.id)
        }
    }
}

//struct MovieDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailScreen()
//            .background(Color.background)
//    }
//}

private struct MovieDetailView: View {
    let movieDetail: MovieDetail

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 12) {
                Text(movieDetail.title)
                    .foregroundColor(.white)
                    .font(.system(size: 32))
                    .fontWeight(.medium)

                Text("\(movieDetail.year) | \(movieDetail.genres) | \(movieDetail.runtimeStr)")
                    .foregroundColor(.gray)
                    .font(.system(size: 18))
                    .fontWeight(.heavy)

                HStack {
                    Text(movieDetail.iMDBRating)
                        .foregroundColor(.white)

                    if let rating = Double(movieDetail.iMDBRating), let ratingInt = Int(rating) {
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

            Text(movieDetail.plot)
                .font(.system(size: 16))
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding(.horizontal, 32)
                .padding(.vertical)


            Section {

                CastView(actorList: movieDetail.actorList)

            } header: {
                Text("Cast")
                    .font(.system(size: 20))
                    .foregroundColor(.white)

            }
            .padding(.horizontal, 32)
        }
    }
}

private struct CastView: View {
    let actorList: [Actor]
    let end: Int
    let moreCount: Int

    init(actorList: [Actor]){
        self.actorList = actorList

        end = min(5, actorList.count)
        moreCount = actorList.count - end
    }

    var body: some View {
        HStack(spacing: -15) {
            ForEach(0..<end-1) { id in
                KFImage
                    .url(URL(string: actorList[id].image))
                    .placeholder {
                        Image("placeholder")
                            .resizable()
                            .opacity(0.3)
                    }
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.background, lineWidth: 2))
            }

            KFImage
                .url(URL(string: actorList[end-1].image))
                .placeholder {
                    Image("placeholder")
                        .resizable()
                        .opacity(0.3)
                }
                .fade(duration: 0.25)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .overlay {
                    ZStack {
                        Color.background
                            .opacity(0.8)

                        Text("\(moreCount)+")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.background, lineWidth: 2))

            Spacer()
        }
    }
}
