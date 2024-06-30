//
//  Item.swift
//  Pokemon - Phicon Test
//
//  Created by Cahaya Ramadhan on 30/06/24.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let id = UUID()  // Use UUID for unique identification
    let name: String
    let url: String
    var types: [PokemonType] = []
    var moves: [PokemonMove] = []

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    var imageURL: URL? {
        // Extract the ID from the URL
        let id = url.split(separator: "/").last.map(String.init) ?? ""
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeWrapper]
    let moves: [PokemonMoveWrapper]
    
    struct PokemonTypeWrapper: Codable, Identifiable {
        let type: PokemonType
        
        var id: String {
            type.name // Ensure each type has a unique identifier
        }
    }
    
    struct PokemonMoveWrapper: Codable, Identifiable {
        let move: PokemonMove
        
        var id: String {
            move.name // Ensure each move has a unique identifier
        }
    }
}

struct PokemonType: Codable {
    let name: String
}

struct PokemonMove: Codable {
    let name: String
}
