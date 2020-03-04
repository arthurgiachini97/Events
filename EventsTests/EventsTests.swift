//
//  EventsTests.swift
//  EventsTests
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import XCTest
@testable import Events
import RxSwift

class EventsTests: XCTestCase {

    let disposeBag = DisposeBag()
    
    func testConnectionError() {
        
        let serviceMock = MockEventsListServiceConnectionError()
        let viewModel = EventsListViewModel(service: serviceMock)
        viewModel.errorOnEvents.subscribe(onError: { error in
            if case APIClientError.NoConnection = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        })
            .disposed(by: disposeBag)
    }
    
    func testDecodeError() {
        
        let serviceMock = MockEventsListServiceDecodeError()
        let viewModel = EventsListViewModel(service: serviceMock)
        viewModel.errorOnEvents.subscribe(onError: { error in
            if case APIClientError.CouldNotDecodeJSON = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        })
            .disposed(by: disposeBag)
    }
    
    func testEventsList() {
        let serviceMock = MockEventsListService()
        let viewModel = EventsListViewModel(service: serviceMock)
        viewModel.events.subscribe(onNext: { events in
            if !events.isEmpty {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        })
            .disposed(by: disposeBag)
    }
}

