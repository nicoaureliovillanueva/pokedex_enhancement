//
//  UIImage+URL.swift
//  Pokemon
//
//  Created by Ben Rosen on 11/10/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setURL(_ url: URL, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
