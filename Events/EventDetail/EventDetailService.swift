//
//  EventDetailService.swift
//  Events
//
//  Created by arthur.giachini on 03/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import RxSwift
import Alamofire

class EventDetailService {
    
    func postCheckIn(checkIn: CheckIn) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            AF.request("https://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin", method: .post, parameters: checkIn.toJSON(), encoder: JSONParameterEncoder.default).response { (response) in
                switch response.result {
                case .success:
                    observer.onNext(true)
                    break
                case .failure:
                    observer.onNext(false)
                    break
                }
            }
            return Disposables.create()
        }
    }
}
