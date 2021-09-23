//
//  HomeCoordinator.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import Foundation
import UIKit
import RxCocoa

class HomeCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        let viewModel = HomeViewModel(coordinator: self)
        controler.configure(viewModel: viewModel)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func navigateAddWineScreen() {
        let addWineCoordinator = AddWineCoordinator(navigationController: navigationController)
        addWineCoordinator.start()
    }
    
    func navigateFilterWineScreen(filterRelay: BehaviorRelay<Filter>) {
        let filterOfWineCoordinator = FilterOfWineCoordinator(navigationController: navigationController)
        filterOfWineCoordinator.start(filterRelay: filterRelay)
    }
    
    func navigateDescriptionWineScreen(model: Wine) {
        let nextCoordinator = DescriptionWineCoordinator(navigationController: navigationController)
        nextCoordinator.start(model: model)
    }
}
