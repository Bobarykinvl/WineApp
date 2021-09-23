//
//  LoginViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
    
    private let userStorage = RealmStorage()
    private let coordinator: LoginCoordinator
    
    private let bag = DisposeBag()
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    
}

// MARK: ViewModelType
extension LoginViewModel: ViewModelType {
    
    struct Input {
        var emailText: Observable<String>
        var passwordText: Observable<String>
        var loginTapped: Observable<Void>
        var signUpTapped: Observable<Void>
    }
    
    struct Output {
        var isActiveButton: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isActiveButton = Observable.combineLatest(input.emailText, input.passwordText).map { (email, password) in
            return email.count >= 3 && password.count >= 3
        }
        
        let model = Observable.combineLatest(input.emailText, input.passwordText).map{
            User(email: $0, password: $1).getRealmModel()
        }
        
        input.loginTapped.withLatestFrom(model).filter{
            self.userStorage.checkUserToLogin(by: $0.email, password: $0.password ) == nil
        }.bind(onNext: { [weak self] model in
            self?.coordinator.showAlert()
        }).disposed(by: bag)
        
        input.loginTapped.withLatestFrom(model).filter{
            self.userStorage.checkUserToLogin(by: $0.email, password: $0.password ) != nil
        }.bind(onNext: { [weak self] model in
            self?.coordinator.navigateHomeScreen()
        }).disposed(by: bag)
 
        input.signUpTapped.bind(onNext: { [weak self] in self?.coordinator.navigateSignUpScreen()
        }).disposed(by: bag)
        return Output(isActiveButton: isActiveButton)
    }
    
}

