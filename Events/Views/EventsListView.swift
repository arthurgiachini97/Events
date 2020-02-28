//
//  EventsListView.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class EventsListView: UIView, ViewCoding {
    
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    let eventsTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        return $0
    }(UITableView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = UIScreen.main.bounds.width
        viewHeight = UIScreen.main.bounds.height
        
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
    }
    
    func addSubviews() {
        addSubview(eventsTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Events Table View
            eventsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: viewHeight * 0.018),
            eventsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupEventsTableView() {
        eventsTableView.rowHeight = viewHeight * 0.18
        eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.description())
    }
}
