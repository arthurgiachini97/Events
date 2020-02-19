//
//  EventsListService.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import Alamofire
import RxSwift

class EventsListService {
    func fetchEvents() -> Observable<[Event]> {
        return Observable.create { (observer) -> Disposable in
            AF.request("https://5b840ba5db24a100142dcd8c.mockapi.io/api/events").validate().responseDecodable(of: [Event].self) { (response) in
                if response.error == nil {
                    do {
                        let result = try response.result.get()
                        observer.onNext(result)
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
        
    }
}
