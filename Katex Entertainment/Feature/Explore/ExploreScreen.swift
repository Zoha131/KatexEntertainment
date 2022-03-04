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
    @State var query = ""
    @FocusState var searchFieldIsFocused: Bool

    var body: some View {
        VStack {
            HStack(spacing: 29) {
                HStack(spacing: 23) {
                    Image("search")
                    TextField("Search", text: $query)
                }
                .focused($searchFieldIsFocused)
                .padding()
                .background(Color.cardBackground)
                .clipShape(Capsule())


                if searchFieldIsFocused {
                    Button("Cancel"){
                        searchFieldIsFocused = false
                        query = ""
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
                    //Staggered Grid
                }
            }
        }
        .background(Color.background)
    }
}

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
    }
}
