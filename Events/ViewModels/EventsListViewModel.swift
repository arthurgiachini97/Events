//
//  EventsListViewModel.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import RxSwift
import RxCocoa

class EventsListViewModel {
    
    var service: EventsListService!
    
    var events = PublishSubject<[Event]>()
    
    let disposeBag = DisposeBag()
    
    init(service: EventsListService = EventsListService()) {
        self.service = service
    }
    
    func fetchEvents() {
        service
            .fetchEvents()
            .subscribe(onNext: { (events) in
                self.events.onNext(events)
            }, onError: { (error) in
                self.events.onError(error)
            })
            .disposed(by: disposeBag)
    }
}
