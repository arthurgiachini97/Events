//
//  PersonCollectionViewCell.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell, ViewCoding {
    
    var nameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    var pictureImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        return $0
    }(UIImageView())
    
    var person: Person! {
        didSet {
            nameLabel.text = person.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(pictureImageView)
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Picture Image View
            pictureImageView.topAnchor.constraint(equalTo: topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: height(-6))
        ])
    }
    
}
