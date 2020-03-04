//
//  EventListServiceProtocol.swift
//  Events
//
//  Created by arthur.giachini on 03/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import RxSwift

protocol EventsListServiceProtocol {
    func fetchEvents() -> Observable<[EventModel]>
}
