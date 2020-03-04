//
//  EventsListService.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import Alamofire
import RxSwift
import Foundation

class EventsListService: EventsListServiceProtocol {
    func fetchEvents() -> Observable<[EventModel]> {
        return Observable.create { (observer) -> Disposable in
            AF.request("https://5b840ba5db24a100142dcd8c.mockapi.io/api/events").validate().responseDecodable(of: [EventModel].self) { (response) in
                if response.error == nil {
                    do {
                        let result = try response.result.get()
                        observer.onNext(result)
                    } catch {
                        observer.onError(APIClientError.NoData)
                    }
                } else {
                    observer.onError(APIClientError.CouldNotDecodeJSON)
                }
            }
            return Disposables.create()
        }
        
    }
}
