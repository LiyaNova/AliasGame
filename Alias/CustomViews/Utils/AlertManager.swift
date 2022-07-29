//
//  AlertManager.swift
//  Alias
//
//  Created by Alex Ch. on 29.07.2022.
//

import UIKit

final class AlertManager {
    
    func showAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alert.addAction(action)
        return alert
    }
}

