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
    
    var service: EventsListServiceProtocol!
    
    var events = BehaviorRelay<[EventModel]>(value: [])
    var errorOnEvents = PublishSubject<Error>()
    
    var eventImage = PublishSubject<UIImage>()
    
    let destiny: PublishSubject<Destiny>
    
    
    let disposeBag = DisposeBag()
    
    init(service: EventsListServiceProtocol = EventsListService(), destiny: PublishSubject<Destiny>) {
        self.service = service
        self.destiny = destiny
    }

    func input(load: Observable<Void>) {
        load.subscribe(onNext: { [weak self] in
            self?.fetchEvents()
        }).disposed(by: disposeBag)
    }

    private func fetchEvents() {
        
        service
            .fetchEvents()
            .subscribe(onNext: { (events) in
                self.events.accept(events)
            }, onError: { (error) in
                self.errorOnEvents.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelectedEvent(viewModel: EventDetailViewModel) {
        destiny.onNext(.eventDetail(viewModel: viewModel))
    }
}
