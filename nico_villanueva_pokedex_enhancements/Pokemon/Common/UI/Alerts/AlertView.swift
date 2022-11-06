//
//  AlertView.swift
//  Pokemon
//
//  Created by Nicks Villanueva on 11/3/22.
//

import Foundation
import UIKit

class AlertView: NSObject {
    class func showAlert(view: UIViewController , title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
