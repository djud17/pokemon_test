//
//  PokemonList.swift
//  Pokemons
//
//  Created by Давид Тоноян  on 15.08.2022.
//

import Foundation

struct PokemonList: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
}
