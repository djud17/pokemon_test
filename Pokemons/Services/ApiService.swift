//
//  ApiClient.swift
//  Pokemons
//
//  Created by Давид Тоноян  on 15.08.2022.
//

import Foundation

enum ApiError: Error {
    case noData
}

enum UrlList: String {
    case pokemonList = "https://pokeapi.co/api/v2/pokemon?limit=1000&offset=0"
}

protocol ApiClient {
    func getPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void)
}

class ApiClientImpl: ApiClient {
    func getPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let session = URLSession.shared
        
        let url = URL(string: UrlList.pokemonList.rawValue)!
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PokemonList.self, from: data)
                completion(.success(response))
            } catch (let error) {
                completion(.failure(error))
            }
            
        }
        
        dataTask.resume()
    }
}
