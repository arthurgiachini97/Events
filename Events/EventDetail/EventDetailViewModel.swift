//
//  EventDetailViewModel.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift
import MapKit
import RxCocoa

class EventDetailViewModel {
    
    var event = BehaviorSubject<Event?>(value: nil)
    var eventImage = BehaviorSubject<UIImage?>(value: nil)
    var people = BehaviorRelay<[Person]>(value: [])
    
    let disposeBag = DisposeBag()
    
    init(event: Event, eventImage: UIImage?) {
        self.event.onNext(event)
        self.eventImage.onNext(eventImage)
        bindPeople()
    }
    
    func mapTitle() -> Observable<String?> {
        return event.map({$0?.title})
    }
    
    func mapPrice() -> Observable<String?> {
        return event.map({String(format: "R$%.2f", $0!.price)})
    }
    
    func mapDescription() -> Observable<String?> {
        return event.map({$0?.description})
    }
    
    private func bindPeople() {
//        people.accept([Person(id: "1", eventId: "1", name: "tuy", picture: "")])
        event
            .map({($0?.people)!})
            .bind(to: people)
            .disposed(by: disposeBag)
    }
}
