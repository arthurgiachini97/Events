//
//  EventDetailViewController.swift
//  Events
//
//  Created by arthur.giachini on 02/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import UIKit
import RxSwift

class EventDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    
    let customView = EventDetailView()
    
    let viewModel: EventDetailViewModel
    
    let disposeBag = DisposeBag()
    
    init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvent()
        doCheckIn()
    }
    
    private func bindEvent() {
        viewModel
            .mapTitle()
            .bind(to: customView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .eventImage
            .bind(to: customView.eventImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModel
            .mapPrice()
            .bind(to: customView.priceLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .mapDescription()
            .bind(to: customView.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .mapLocation()
            .subscribe(onNext: { location in
                if let location = location {
                    self.customView.setMapViewLocation(location: location)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel
            .people
            .observeOn(MainScheduler.instance)
            .bind(to: customView
                .peopleCollectionView
                .rx
                .items(cellIdentifier: PersonCollectionViewCell.description(), cellType: PersonCollectionViewCell.self)) { (row, person, cell) in
                    cell.person = person
        }
        .disposed(by: disposeBag)
    }
    
    private func doCheckIn() {
        
        customView.checkinButton.rx.tap.subscribe { (_) in
            self.customView.lock(style: .large)
            let name = self.customView.checkinNameTextField.text
            let email = self.customView.checkinEmailTextField.text
            let verified = self.viewModel.verifyUserInfo(name: name, email: email)
            if verified {
                self.viewModel.postCheckIn(checkIn: CheckIn(eventId: "", name: name!, email: email!))
            } else {
                self.customView.unlock()
                self.present(UIAlertController.simpleAlert(title: "Ops!", message: "Por favor preencha os dois campos para realizar o Check In", buttonTitle: "OK"), animated: true)
            }
        }
        .disposed(by: disposeBag)
        
        viewModel
            .successCheckIn
            .subscribe(onNext: { (success) in
                self.customView.unlock()
                self.present(UIAlertController.simpleAlert(title: "Sucesso!", message: "Seu Check In foi realizado com successo!", buttonTitle: "Eba!"), animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .errorCheckIn
            .subscribe(onNext: { (failure) in
                self.customView.unlock()
                self.present(UIAlertController.simpleAlert(title: "Erro!", message: "Não foi possível realizar seu Check In.", buttonTitle: "Ok"), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
