//
//  EventTableViewCell.swift
//  Events
//
//  Created by arthur.giachini on 27/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift

class EventTableViewCell: UITableViewCell, ViewCoding {
    
    private var viewWidth: CGFloat = 0
    private var viewHeight: CGFloat = 0
    
    var viewModel = EventCellViewModel()
    
    let disposeBag = DisposeBag()
    
    var event: Event! {
        didSet {
            titleLabel.text = event.title
            viewModel.fetchEventImage(stringUrl: event.image)
        }
    }
    
    var roundedView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 10.0
        $0.backgroundColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: -3, height: 4)
        $0.layer.shadowRadius = 5
        return $0
    }(UIView())
    
    var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    var eventImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewWidth = UIScreen.main.bounds.width
        viewHeight = UIScreen.main.bounds.height
        
        setupLayout()
        
        self.viewModel.imageDownloaded.subscribe(onNext: { (image) in
            self.eventImageView.image = image
        })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        roundedView.addSubview(titleLabel)
        roundedView.addSubview(eventImageView)
        addSubview(roundedView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Rounded View
            roundedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            roundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundedView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            roundedView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            
            // Event Image View
            eventImageView.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: viewWidth * 0.0426667),
            eventImageView.heightAnchor.constraint(equalTo: roundedView.heightAnchor, multiplier: 0.8),
            eventImageView.widthAnchor.constraint(equalTo: roundedView.widthAnchor, multiplier: 0.2),
            
            // Title Label
            titleLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: viewWidth * 0.0426667),
            titleLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: viewWidth * -0.0426667),
        ])
    }
}

