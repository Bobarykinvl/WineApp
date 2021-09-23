//
//  SignUpViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var newEmailField: UITextField!
    @IBOutlet private weak var newPasswordField: UITextField!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel: SignUpViewModel?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
           view.addGestureRecognizer(tap)
        self.navigationController?.isNavigationBarHidden = true
        
        bind()
    }
    
    func configure(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func hiddenKeyboard(tap: UITapGestureRecognizer) {
        view.endEditing(true)
      }
}

// MARK: Binding
extension SignUpViewController {
    
    func bind() {
        let input = SignUpViewModel.Input(newEmailText: newEmailField.rx.text.map { $0 ?? ""}.asDriver(onErrorJustReturn: ""), newPasswordText: newPasswordField.rx.text.map { $0 ?? ""}.asDriver(onErrorJustReturn: ""), createAccountTapped: createAccountButton.rx.tap.asDriver(), loginButton: loginButton.rx.tap.asDriver())
        
        guard let viewModel = viewModel else { return }
        let output = viewModel.transform(input: input)
        
        output.createAccountButtonIsActive.drive(createAccountButton.rx.isEnabled).disposed(by: bag)
        output.createAccountButtonIsActive.map { $0 ? 1 : 0.1 }.drive(createAccountButton.rx.alpha).disposed(by: bag)
    }
}
