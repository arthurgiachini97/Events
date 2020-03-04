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

    var viewModel = EventCellViewModel()
    
    let disposeBag = DisposeBag()
    
    var event: EventModel! {
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
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 5.0
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        
        viewModel
            .imageDownloaded
            .subscribe(onNext: { (image) in
                self.eventImageView.image = image
                self.eventImageView.unlock()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .imageFailure
            .subscribe(onNext: { (error) in
                self.eventImageView.backgroundColor = .lightGray
                self.eventImageView.unlock()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        eventImageView.lock(style: .medium)
        
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
            eventImageView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant:  width(16)),
            eventImageView.heightAnchor.constraint(equalTo: roundedView.heightAnchor, multiplier: 0.75),
            eventImageView.widthAnchor.constraint(equalTo: roundedView.widthAnchor, multiplier: 0.22),
            
            // Title Label
            titleLabel.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: width(16)),
            titleLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: width(-16)),
        ])
    }
}

