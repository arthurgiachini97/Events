//
//  UIViewExtension.swift
//  Events
//
//  Created by arthur.giachini on 28/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

public extension UIView {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    private static let backdropViewTag = 1001
    private static let activityViewTag = 1002
    
    func lock() {
        let backdrop = UIView()
        backdrop.backgroundColor = .white
        backdrop.tag = UIView.backdropViewTag
        
        addSubview(backdrop)
        
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backdrop.centerXAnchor.constraint(equalTo: centerXAnchor),
            backdrop.centerYAnchor.constraint(equalTo: centerYAnchor),
            backdrop.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdrop.topAnchor.constraint(equalTo: topAnchor),
            backdrop.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let activityView = UIActivityIndicatorView()
        activityView.style = .medium
        activityView.color = .black
        activityView.tag = UIView.activityViewTag
        activityView.startAnimating()
        
        addSubview(activityView)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func unlock() {
        self.viewWithTag(UIView.backdropViewTag)?.removeFromSuperview()
        self.viewWithTag(UIView.activityViewTag)?.removeFromSuperview()
    }
}

