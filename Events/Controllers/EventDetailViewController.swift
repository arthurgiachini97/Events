//
//  EventDetailViewController.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let customView = EventsListView()
    
    var viewModel: EventDetailViewModel!
    
    init(viewModel: EventDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        print(self.viewModel.event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
