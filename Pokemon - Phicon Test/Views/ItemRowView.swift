//
//  ItemRowView.swift
//  Pokemon - Phicon Test
//
//  Created by Cahaya Ramadhan on 30/06/24.
//

import SwiftUI

struct ItemRowView: View {
    let item: Pokemon

    var body: some View {
        NavigationLink(destination: DetailView(pokemon: item).environmentObject(NetworkManager())) {
            HStack {
                if let imageURL = item.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text(item.name.capitalized)
                        .font(.headline)
                }
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {  // Wrap in NavigationView for preview
            ItemRowView(item: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
        }
    }
}



