//
//  SignUpModelView.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewModel {
    
    private let userStorage = RealmStorage()
    private let emailValidator = EmailValidator()
    private let bag = DisposeBag()
    
    private let coordinator: SignUpCoordinator
    
    init(coordinator: SignUpCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: ViewModelType
extension SignUpViewModel: ViewModelType {
    
    struct Input {
        var newEmailText: Driver<String>
        var newPasswordText: Driver<String>
        var createAccountTapped: Driver<Void>
        var loginButton: Driver<Void>
    }
    
    struct Output {
        var createAccountButtonIsActive: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        
        let createAccountButtonIsActive = Driver.combineLatest(input.newEmailText, input.newPasswordText).map { (email, password) in
            return email.count >= 3 && password.count >= 3
        }
        
        let model = Driver.combineLatest(input.newEmailText, input.newPasswordText).map {
            User(email: $0, password: $1).getRealmModel()
        }
        
        input.createAccountTapped.withLatestFrom(model).filter{ [weak self] in
            self?.userStorage.getUser(by: $0.email) != nil
        }.debug().drive(onNext: { [weak self] model in
            self?.coordinator.showAlert()
        }).disposed(by: bag)
        
        input.createAccountTapped.withLatestFrom(model).filter{ [weak self] in
            self?.userStorage.getUser(by: $0.email) == nil
        }.drive(onNext: { model in
            self.userStorage.saveUser(object: model)
            self.coordinator.navigateHomeScreen()
        }).disposed(by: self.bag)
        
        input.loginButton.drive(onNext: { [weak self] in
            self?.coordinator.navigateLoginScreen()
        }).disposed(by: bag)
        
        return Output(createAccountButtonIsActive: createAccountButtonIsActive)
    }
}
