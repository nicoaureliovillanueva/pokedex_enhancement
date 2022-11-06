//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit
import ZoogleAnalytics

class PokemonListViewController: UIViewController {

    
    let viewModel = PokemonListViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    private let loadingReuseIdentifier = "loading"
    private let pokemonItemReuseIdentifier = "pokemon"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getNavigationTitle()
        configureTableView()
        
        viewModel.fetchMorePokemon { success in
            if success {
                self.tableView.reloadData()
            } else {
                self.pokemonFetchFailed()
            }
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: loadingReuseIdentifier)
        tableView.register(UINib(nibName: "PokemonListItemTableViewCell", bundle: nil), forCellReuseIdentifier: pokemonItemReuseIdentifier)
    }

    private func pokemonFetchFailed() {
        AlertView.showAlert(view: self,
                            title: NSLocalizedString("error_alert_fetch", comment: ""),
                            message: "")
    }

    private func pokemonIdNotFound() {
        AlertView.showAlert(view: self,
                            title: NSLocalizedString("error_alert_id_not_found", comment: ""),
                            message: "")

    }
}

// MARK: UITableView Delegate

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = viewModel.pokemon.count
        if viewModel.morePokemonToLoad {
            rowCount += 1
        }
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?

        if indexPath.row >= viewModel.pokemon.count {
            cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseIdentifier)
            viewModel.fetchMorePokemon(completion: { success in
                if success {
                    self.tableView.reloadData()
                }else {
                    self.pokemonFetchFailed()
                }
            })
        } else if let pokemonCell = tableView.dequeueReusableCell(withIdentifier: pokemonItemReuseIdentifier) as? PokemonListItemTableViewCell {
            pokemonCell.titleLabel.text = viewModel.pokemon[indexPath.row].name.capitalized
            cell = pokemonCell
        }

        guard let cell = cell else {
            fatalError("Could not find a cell")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.pokemon.count else {
            return
        }

        guard let pokemonId = viewModel.pokemon[indexPath.row].id else {
            pokemonIdNotFound()
            return
        }

        ZoogleAnalytics.shared.log(event: ZoogleAnalyticsEvent(key: "pokemon_selected", parameters: ["id": pokemonId]))
        
        navigationController?.show(PokemonDetailsViewController(id: pokemonId), sender: self)
    }
    
}
