//
//  DisplayError.swift
//  TopJavaRepos
//
//  Created by Victor Tavares on 05/11/17.
//  Copyright © 2017 VSemedo. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayError {
    func onError(_ message: String)
}

extension DisplayError where Self: UIViewController {
    
    func onError(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("STR_ERROR", comment: ""), message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("STR_OK", comment: ""), style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
