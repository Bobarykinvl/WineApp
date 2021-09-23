//
//  DescriptionWineController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 7.08.21.
//

import UIKit

class DescriptionWineCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(model: Wine) {
        let storyboard: UIStoryboard = UIStoryboard(name: "DescriptionWine", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "DescriptionWineViewController") as? DescriptionWineViewController else { return }
        controler.configure(model: model)
        navigationController?.pushViewController(controler, animated: true)
    }
}
