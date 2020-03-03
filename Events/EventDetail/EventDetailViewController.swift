//
//  EventDetailViewController.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let customView = EventDetailView()
    
    var viewModel: EventDetailViewModel!
    
    let disposeBag = DisposeBag()
    
    init(viewModel: EventDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvent()
    }
    
    private func bindEvent() {
        viewModel
            .mapTitle()
            .bind(to: customView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .eventImage
            .bind(to: customView.eventImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModel
            .mapPrice()
            .bind(to: customView.priceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .mapDescription()
            .bind(to: customView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        print( "people:\(viewModel.people.value)")
        viewModel
            .people
            .observeOn(MainScheduler.instance)
            .bind(to: customView
                .peopleCollectionView
                .rx
                .items(cellIdentifier: PersonCollectionViewCell.description(), cellType: PersonCollectionViewCell.self)) { (row, person, cell) in
                    cell.person = person
        }
        .disposed(by: disposeBag)
    }
}
