//
//  UIAlertControllerExtension.swift
//  Events
//
//  Created by arthur.giachini on 03/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func simpleAlert(title: String? = nil, message: String? = nil, buttonTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: UIAlertAction.Style.cancel, handler: nil))
        return alert
    }
}
