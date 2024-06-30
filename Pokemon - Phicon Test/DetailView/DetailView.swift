//
//  DetailView.swift
//  Pokemon - Phicon Test
//
//  Created by Cahaya Ramadhan on 30/06/24.
//

import SwiftUI

struct DetailView: View {
    let pokemon: Pokemon
    @State private var detail: PokemonDetail?
    
    var body: some View {
        VStack {
            // Display Pokémon details
            Text("Types:")
                .font(.headline)
            if let types = detail?.types {
                ForEach(types) { typeWrapper in
                    Text(typeWrapper.type.name.capitalized)
                        .padding(.bottom, 1)
                }
            }
            
            Text("Moves:")
                .font(.headline)
            if let moves = detail?.moves {
                ForEach(moves) { moveWrapper in
                    Text(moveWrapper.move.name.capitalized)
                        .padding(.bottom, 1)
                }
            }
            
            // Additional content like catching Pokémon button
        }
        .onAppear {
            // Fetch Pokémon details if not already fetched
            if detail == nil {
                fetchPokemonDetail()
            }
        }
    }
    
    private func fetchPokemonDetail() {
        // Fetch Pokémon detail from network or other source
        // Example implementation
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch Pokémon detail: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(PokemonDetail.self, from: data)
                DispatchQueue.main.async {
                    self.detail = decodedData
                }
            } catch {
                print("Error decoding Pokémon detail: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
    }
}

