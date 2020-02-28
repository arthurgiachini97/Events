//
//  EventsListView.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class EventsListView: UIView, ViewCoding {
    
    let eventsTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        return $0
    }(UITableView())
    
    let errorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Erro no carregamento. Tente novamente."
        $0.isHidden = true
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let tryAgainButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "tryAgain"), for: .normal)
        $0.isHidden = true
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        setupEventsTableView()
        setupTryAgainButton()
    }
    
    func addSubviews() {
        addSubview(eventsTableView)
        addSubview(errorLabel)
        addSubview(tryAgainButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Events Table View
            eventsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: height(12)),
            eventsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Error Label
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Try Again button
            tryAgainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor)
        ])
    }
    
    private func setupEventsTableView() {
        eventsTableView.rowHeight = height(120)
        eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.description())
    }
    
    private func setupTryAgainButton() {
        tryAgainButton.contentEdgeInsets = UIEdgeInsets(top: height(20), left: width(20), bottom: height(20), right: width(20))
    }
}
