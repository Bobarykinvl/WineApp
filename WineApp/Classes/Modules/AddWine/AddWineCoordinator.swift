//
//  AddWineCoordinator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 12.08.21.
//

import Foundation
import UIKit

class AddWineCoordinator {
    
    private let picker = UIImagePickerController()
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "AddWine", bundle: nil)
        guard let controller = storyboard.instantiateViewController(identifier: "AddWineViewController") as? AddWineViewController else { return }
        let viewModel = AddWineViewModel(coordinator: self)
        controller.configure(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func navigateHomeScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}
