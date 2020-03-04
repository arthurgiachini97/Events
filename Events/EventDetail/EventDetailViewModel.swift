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
    
    var service: EventDetailService!
    
    var event = BehaviorSubject<EventModel?>(value: nil)
    var eventImage = BehaviorSubject<UIImage?>(value: nil)
    var people = BehaviorRelay<[Person]>(value: [])
    
    var successCheckIn = PublishSubject<Bool>()
    var errorCheckIn = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init(event: EventModel, eventImage: UIImage?, service: EventDetailService = EventDetailService()) {
        self.event.onNext(event)
        self.eventImage.onNext(eventImage)
        self.service = service
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
    
    func mapLocation() -> Observable<CLLocationCoordinate2D?> {
        return event.map({
            guard let latitude = $0?.latitude, let longitude = $0?.longitude else {
                return nil
            }
            return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        })
    }
    
    private func bindPeople() {
        event
            .map({($0?.people)!})
            .bind(to: people)
            .disposed(by: disposeBag)
    }
    
    func postCheckIn(checkIn: CheckIn) {
        service
            .postCheckIn(checkIn: checkIn)
            .subscribe(onNext: { (_) in
                self.successCheckIn.onNext(true)
            }, onError: { (_) in
                self.successCheckIn.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    func verifyUserInfo(name: String?, email: String?) -> Bool {
        if name != "" && email != "" {
            return true
        } else {
            return false
        }
    }
}
