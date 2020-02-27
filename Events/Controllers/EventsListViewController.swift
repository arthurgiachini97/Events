//
//  EventsListViewController.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift

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
            .subscribe(onNext: { (events) in
                print(events)
            })
            .disposed(by: disposeBag)
    }

}
