//
//  MainCoordinator.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class MainCoordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        goToEventsList()
    }
    
    func goToEventsList() {
        let vc = EventsListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
