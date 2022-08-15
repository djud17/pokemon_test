//
//  ViewController.swift
//  Pokemons
//
//  Created by Давид Тоноян  on 15.08.2022.
//

import UIKit

class PokemonListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let apiClient: ApiClient = ApiClientImpl()
    var pokemonList: PokemonList?
    var filterredPokemonList = [Pokemon]() {
        didSet {
            filterredPokemonList.sort {$0.name < $1.name}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        loadData()
    }
    
    private func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.frame.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 1.5,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                cell.transform = CGAffineTransform.identity
            })
            delay += 1
        }
    }
    
    private func loadData() {
        apiClient.getPokemonList { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.pokemonList = nil
                    self.showError(error)
                case .success(let result):
                    self.pokemonList = result
                    self.filterredPokemonList = result.results
                    self.showData()
                }
            }
        }
    }
    
    private func showData() {
        animateTableView()
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error!", message: "Parsing error: \(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Reload", style: .default) { _ in
            self.loadData()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
