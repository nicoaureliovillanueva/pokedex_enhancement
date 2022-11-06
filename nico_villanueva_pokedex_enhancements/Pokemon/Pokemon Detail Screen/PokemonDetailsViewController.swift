//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    var viewModel: PokemonDetailsViewModel?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var loadingView: UIView!

    @IBOutlet weak var viewContainer: UIView!
    
    
    init(id: String) {
        viewModel = PokemonDetailsViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius = 30
        fetchDetails()
    }
    
    private func configureUI() {
        titleLabel.text = viewModel?.getPokemonName()
        
        typesLabel.text = viewModel?.getTypes()
        weightLabel.text = viewModel?.getWeight()
        heightLabel.text = viewModel?.getHeight()

        imageView.setURL((viewModel?.getPokemonImage())!, completion: { [weak self] success in
            if !success {
                self?.imageView.image = UIImage(named: "unknown")
            }
            self?.loadingView.isHidden = true
        })
    }
    
    private func fetchDetails() {
        viewModel?.fetchPokemonDetails(completion: { success in
            if success {
                self.configureUI()
            }else {
                self.pokemonFetchFailed()
            }
        })
    }

    private func pokemonFetchFailed() {
        
        let alert = UIAlertController(title: nil,
            message: NSLocalizedString("error_alert_unable_to_display_details", comment: ""),
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("btn_title_retry", comment: ""), style: .default, handler: { [weak self] _ in
            self?.fetchDetails()
        }))
        present(alert, animated: true, completion:nil)
    }
    
    
}
