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
        $0.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let priceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.3491520882, green: 0.6419227123, blue: 0.1775221229, alpha: 1)
        $0.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
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
    
    let collectionViewTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Pessoas"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return $0
    }(UILabel())
    
    let peopleCollectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    let checkinView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.3491520882, green: 0.6419227123, blue: 0.1775221229, alpha: 1)
        return $0
    }(UIView())
    
    let checkinTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Faça o Check In no evento!"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    let checkinNameTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Nome"
        $0.backgroundColor = .white
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    let checkinEmailTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Email"
        $0.backgroundColor = .white
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    let checkinButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Check In", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(#colorLiteral(red: 0.3491520882, green: 0.6419227123, blue: 0.1775221229, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 10
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
        contentView.addSubview(collectionViewTitleLabel)
        contentView.addSubview(peopleCollectionView)
        contentView.addSubview(checkinView)
        checkinView.addSubview(checkinTitleLabel)
        checkinView.addSubview(checkinNameTextField)
        checkinView.addSubview(checkinEmailTextField)
        checkinView.addSubview(checkinButton)
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
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: width(8)),
            
            // Description Label
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: height(24)),
            
            // Map View
            mapView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: height(20)),
            mapView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9/16),
            
            // Collection View Title Label
            collectionViewTitleLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: height(16)),
            collectionViewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: width(16)),
            collectionViewTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // People Collection View
            peopleCollectionView.topAnchor.constraint(equalTo: collectionViewTitleLabel.bottomAnchor, constant: height(8)),
            peopleCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            peopleCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            peopleCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12),
            
            // Post View
            checkinView.topAnchor.constraint(equalTo: peopleCollectionView.bottomAnchor, constant: height(16)),
            checkinView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            checkinView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            checkinView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -30),
            
            // CheckIn Title Label
            checkinTitleLabel.topAnchor.constraint(equalTo: checkinView.topAnchor, constant: height(16)),
            checkinTitleLabel.leadingAnchor.constraint(equalTo: checkinView.leadingAnchor, constant: width(16)),
            checkinTitleLabel.centerXAnchor.constraint(equalTo: checkinView.centerXAnchor),
            
            // CheckIn Name Text Field
            checkinNameTextField.leadingAnchor.constraint(equalTo: checkinTitleLabel.leadingAnchor),
            checkinNameTextField.centerXAnchor.constraint(equalTo: checkinView.centerXAnchor),
            checkinNameTextField.topAnchor.constraint(equalTo: checkinTitleLabel.bottomAnchor, constant: height(16)),
            checkinNameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            // CheckIn Email Text Field
            checkinEmailTextField.leadingAnchor.constraint(equalTo: checkinTitleLabel.leadingAnchor),
            checkinEmailTextField.centerXAnchor.constraint(equalTo: checkinView.centerXAnchor),
            checkinEmailTextField.topAnchor.constraint(equalTo: checkinNameTextField.bottomAnchor, constant: height(16)),
            checkinEmailTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04),
            
            // CheckIn Button
            checkinButton.topAnchor.constraint(equalTo: checkinEmailTextField.bottomAnchor, constant: height(18)),
            checkinButton.leadingAnchor.constraint(equalTo: checkinView.leadingAnchor, constant: width(50)),
            checkinButton.centerXAnchor.constraint(equalTo: checkinView.centerXAnchor),
            checkinButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
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
