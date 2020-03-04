//
//  EventTableViewCellModel.swift
//  Events
//
//  Created by arthur.giachini on 28/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class EventCellViewModel {
    
    var service: EventCellService!
    
    var imageDownloaded = PublishSubject<UIImage>()
    var imageFailure = PublishSubject<Error>()
    
    let disposeBag = DisposeBag()
    
    init(service: EventCellService = EventCellService()) {
        self.service = service
    }
    
    func fetchEventImage(stringUrl: String) {
        service
            .fetchEventImage(stringUrl: stringUrl)
            .materialize()
            .subscribe(onNext: { (event) in
                switch event {
                case .next(let image):
                    self.imageDownloaded.onNext(image)
                    break
                case .error(let error):
                    self.imageFailure.onNext(error)
                    break
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
}
