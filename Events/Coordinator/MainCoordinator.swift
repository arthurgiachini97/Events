//
//  MainCoordinator.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift

enum Destiny {
    case eventDetail(viewModel: EventDetailViewModel)
}

class MainCoordinator {
    
    let destiny = PublishSubject<Destiny>()
    
    let navigationController: UINavigationController
    
    let disposeBag = DisposeBag()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        goToEventsList()
        
        destiny.subscribe(onNext: { (destiny) in
            switch destiny {
            case .eventDetail(let viewModel):
                self.goToEventDetail(viewModel: viewModel)
                break
            }
        })
        .disposed(by: disposeBag)
    }
    
    func goToEventsList() {
        let viewModel = EventsListViewModel(destiny: destiny)
        let vc = EventsListViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToEventDetail(viewModel: EventDetailViewModel) {
        let vc = EventDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
