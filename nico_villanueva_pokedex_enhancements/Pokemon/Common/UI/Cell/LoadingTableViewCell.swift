//
//  LoadingTableViewCell.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }
}
