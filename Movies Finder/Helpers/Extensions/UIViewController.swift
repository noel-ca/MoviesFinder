//
//  UIViewController.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(onViewController vc: UIViewController,
                          title:String?,
                          mssg:String) {
        let alert = UIAlertController.init(title: title, message: mssg, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default)
        alert.addAction(ok)
        vc.present(alert, animated: true) {}
    }
}
