//
//  LoginViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private var viewModel: LoginViewModel?
    private let bag = DisposeBag()
    private var realmLogin = RealmUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
           view.addGestureRecognizer(tap)
    }
    
    func configure(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func hiddenKeyboard(tap: UITapGestureRecognizer) {
        view.endEditing(true)
      }
}

// MARK: Binding
extension LoginViewController {
    
    func bind() {
        guard let viewModel = viewModel else { return }
        let input = LoginViewModel.Input(emailText: emailField.rx.text.map{$0 ?? " "}, passwordText: passwordField.rx.text.map{$0 ?? " "}, loginTapped: loginButton.rx.tap.asObservable(), signUpTapped: signUpButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        output.isActiveButton.bind(to: loginButton.rx.isEnabled).disposed(by: bag)
        output.isActiveButton.map{ $0 ? 1 : 0.1}.bind(to: loginButton.rx.alpha).disposed(by: bag)
    }
}

// MARK: Setup
extension LoginViewController {
    
    func setup() {
        self.navigationController?.isNavigationBarHidden = true
    }
}
