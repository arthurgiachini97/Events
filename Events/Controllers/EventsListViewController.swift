//
//  EventsListViewController.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class EventsListViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let customView = EventsListView()
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
