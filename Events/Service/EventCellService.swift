//
//  EventCellService.swift
//  Events
//
//  Created by arthur.giachini on 28/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import Alamofire
import RxSwift
import UIKit

class EventCellService {
    func fetchEventImage(stringUrl: String) -> Observable<UIImage> {
        return Observable.create { (observer) -> Disposable in
            AF.request(stringUrl).responseData(queue: .main) { (response) in
                if response.error == nil {
                    if let responseData = response.data {
                        if let image = UIImage(data: responseData) {
                            observer.onNext(image)
                        } else {
                            observer.onError(APIClientError.NoData)
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
