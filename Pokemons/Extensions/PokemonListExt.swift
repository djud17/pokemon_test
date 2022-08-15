//
//  PokemonListExt.swift
//  Pokemons
//
//  Created by Давид Тоноян  on 15.08.2022.
//

import UIKit

extension PokemonListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterredPokemonList = []
        
        if let pokemonList = pokemonList {
            if searchText != "" {
                filterredPokemonList = pokemonList.results.filter {$0.name.lowercased().contains(searchText.lowercased())}
                
                if filterredPokemonList.isEmpty {
                    tableView.setEmptyMessage("No pokemon with name: \(searchText)")
                } else {
                    tableView.restore()
                }
            } else {
                filterredPokemonList = pokemonList.results
            }
        }
        tableView.reloadData()
    }
}

extension PokemonListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterredPokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if !filterredPokemonList.isEmpty {
            let model = filterredPokemonList[indexPath.row]
            cell.textLabel?.text = model.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !filterredPokemonList.isEmpty {
            let alert = UIAlertController(title: "Pokemon", message: "Pokemon name: \(filterredPokemonList[indexPath.row].name)", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pokemon list:"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
