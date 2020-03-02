//
//  EventDetailView.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class EventDetailView: UIView, ViewCoding {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
}
