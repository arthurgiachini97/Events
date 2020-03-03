//
//  EventsListViewController.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class EventsListViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let customView = EventsListView()
    
    var viewModel: EventsListViewModel!
    
    var indexPath: IndexPath!
    
    let disposeBag = DisposeBag()
    
    init(viewModel: EventsListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.lock(style: .large)
        viewModel.fetchEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSuccessState()
        bindEvents()
        setupErrorState()
        setupTryAgainAction()
        eventSelected()
    }
    
    private func setupSuccessState() {
        viewModel
            .events
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (events) in
                self.customView.eventsTableView.isHidden = false
                self.customView.errorLabel.isHidden = true
                self.customView.tryAgainButton.isHidden = true
                self.customView.unlock()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindEvents() {
        viewModel
            .events
            .observeOn(MainScheduler.instance)
            .bind(to: customView.eventsTableView.rx.items(cellIdentifier: EventTableViewCell.description(), cellType: EventTableViewCell.self)) { (row, event, cell) in
                cell.event = event
        }
        .disposed(by: disposeBag)
    }
    
    private func setupErrorState() {
        viewModel
            .errorOnEvents
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                self.customView.eventsTableView.isHidden = true
                self.customView.errorLabel.isHidden = false
                self.customView.tryAgainButton.isHidden = false
                self.customView.unlock()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTryAgainAction() {
        customView.tryAgainButton.rx.tap.subscribe { (_) in
            self.customView.lock(style: .large)
            self.viewModel.fetchEvents()
        }
        .disposed(by: disposeBag)
    }
    
    private func eventSelected() {
        customView.eventsTableView.rx.itemSelected.bind { (indexPath) in
            let cell = self.customView.eventsTableView.cellForRow(at: indexPath) as! EventTableViewCell
            self.coordinator?.goToEventDetail(event: self.viewModel.events.value[indexPath.row], eventImage: cell.eventImageView.image)
        }
        .disposed(by: disposeBag)
    }
}
