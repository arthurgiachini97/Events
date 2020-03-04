//
//  MockEventsListService.swift
//  EventsTests
//
//  Created by arthur.giachini on 03/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

@testable import Events
import RxSwift

class MockEventsListServiceConnectionError: EventsListServiceProtocol {
    func fetchEvents() -> Observable<[EventModel]> {
        let sub = BehaviorSubject<[EventModel]>(value: [])
        sub.onError(APIClientError.NoConnection)
        return sub.asObserver()
    }
}

class MockEventsListServiceDecodeError: EventsListServiceProtocol {
    func fetchEvents() -> Observable<[EventModel]> {
        let sub = BehaviorSubject<[EventModel]>(value: [])
        sub.onError(APIClientError.CouldNotDecodeJSON)
        return sub.asObserver()
    }
}

class MockEventsListService: EventsListServiceProtocol {
    func fetchEvents() -> Observable<[EventModel]> {
        let events = [EventModel(people:  nil, date: 500, description: "description", image: "image", longitude: 2, latitude: 2, price: 20.0, title: "title", id: "1", cupons: nil), EventModel(people:  nil, date: 500, description: "description2", image: "image2", longitude: 2, latitude: 2, price: 20.0, title: "title2", id: "2", cupons: nil)]
        let sub = BehaviorSubject<[EventModel]>(value: events)
        return sub.asObserver()
    }
}
