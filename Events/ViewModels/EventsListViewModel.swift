//
//  EventsListViewModel.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

class EventsListViewModel {
    
    var service: EventsListService!
    
    var events = PublishSubject<[Event]>()
    
    var eventImage = PublishSubject<UIImage>()
    
    let disposeBag = DisposeBag()
    
    init(service: EventsListService = EventsListService()) {
        self.service = service
    }
    
    func fetchEvents() {
        service
            .fetchEvents()
            .materialize()
            .subscribe(onNext: { (event) in
                switch event {
                case .next(let events):
                    self.events.onNext(events)
                    break
                case .error(_):
                    break
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
