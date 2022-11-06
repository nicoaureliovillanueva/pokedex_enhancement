//
//  PokemonListItemTableViewCell.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit

class PokemonListItemTableViewCell: UITableViewCell {

    @IBOutlet var viewContainer: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContainer.layer.cornerRadius = 10
    }
    
}
