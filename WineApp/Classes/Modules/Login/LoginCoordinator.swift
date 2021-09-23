//
//  LoginCoordinator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import UIKit

class LoginCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        let viewModel = LoginViewModel(coordinator: self)
        controler.configure(viewModel: viewModel)
        navigationController.pushViewController(controler, animated: true)
        window?.rootViewController = navigationController
    }
    
    func navigateHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    func navigateSignUpScreen() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
        signUpCoordinator.start()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Wine app Error", message: "Упс, неверный email или пароль", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { UIAlertAction in
            print("Tapped OK")
        }))
        self.navigationController.present(alert, animated: true)
    }
}
