//
//  EventDetailView.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import MapKit

class EventDetailView: UIView, ViewCoding {
    
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    let eventImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.numberOfLines = 0
//        $0.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return $0
    }(UILabel())
    
    let priceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let mapView: MKMapView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(MKMapView())
    
    let peopleCollectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blue
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
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
        registerAndSetupPeopleCollectionView()
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(eventImage)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(peopleCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Event Image
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            eventImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/16),
            
            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: width(16)),
            titleLabel.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: height(16)),
            
            // Price Label
            priceLabel.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: height(20)),
            priceLabel.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: width(-16)),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: width(24)),
            
            // Description Label
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: height(24)),
            
            // Map View
            mapView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: height(20)),
            mapView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/16),
            
            // People Collection View
            peopleCollectionView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: height(20)),
            peopleCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            peopleCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            peopleCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12),
            peopleCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -30),
             
        ])
    }
    
    private func registerAndSetupPeopleCollectionView() {
        peopleCollectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.description())
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: height(60), height: height(60))
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: width(16), bottom: 0, right: width(16))
        flowLayout.scrollDirection = .horizontal
        peopleCollectionView.collectionViewLayout = flowLayout
    }
}
