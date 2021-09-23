//
//  SignUpCoordinator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import Foundation
import UIKit

class SignUpCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: Bundle.main)
        guard let controler = storyboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController else { return }
        let viewModel = SignUpViewModel(coordinator: self)
        controler.configure(viewModel: viewModel)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func navigateLoginScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Wine app Error", message: "Упс, такой email уже существует", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { UIAlertAction in
            print("Tapped OK")
        }))
        self.navigationController?.present(alert, animated: true)
    }
}
