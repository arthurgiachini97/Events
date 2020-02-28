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
        viewModel.fetchEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel
            .events
            .observeOn(MainScheduler.instance)
            .bind(to: customView.eventsTableView.rx.items(cellIdentifier: EventTableViewCell.description(), cellType: EventTableViewCell.self)) { (row, event, cell) in
                cell.event = event
                AF.request(event.image).responseData(queue: .main) { (response) in
                    if response.error == nil {
                        if let responseData = response.data {
                            cell.eventImageView.image = UIImage(data: responseData)
                        }
                    }
                }
        }
        .disposed(by: disposeBag)
    }
    
}
