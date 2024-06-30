//
//  NetworkManager.swift
//  Pokemon - Phicon Test
//
//  Created by Cahaya Ramadhan on 30/06/24.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var items = [Pokemon]()
    private var cancellable: AnyCancellable?
    private var detailCancellable: AnyCancellable?
    var nextURL: String? = "https://pokeapi.co/api/v2/pokemon/"
    
    func fetchData() {
        guard let urlString = nextURL, let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonResponse.self, decoder: JSONDecoder())
            .map { response in
                self.nextURL = response.next
                return self.items + response.results
            }
            .map { items in
                items.sorted(by: { $0.name < $1.name }) // Sort the items alphabetically by name
            }
            .replaceError(with: []) // Replace decoding errors with an empty array
            .receive(on: DispatchQueue.main)
            .assign(to: \.items, on: self)
    }

    func fetchPokemonDetail(pokemon: Pokemon, completion: @escaping (PokemonDetail) -> Void) {
        guard let url = URL(string: pokemon.url) else {
            completion(PokemonDetail(id: 0, name: "", types: [], moves: [])) // Return an empty PokemonDetail
            return
        }

        detailCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PokemonDetail.self, decoder: JSONDecoder())
            .replaceError(with: PokemonDetail(id: 0, name: "", types: [], moves: [])) // Replace decoding errors with an empty PokemonDetail
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
    }
}




