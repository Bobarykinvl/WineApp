//
//  FilterOfWine.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import UIKit
import RxCocoa

class FilterOfWineCoordinator {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(filterRelay: BehaviorRelay<Filter>) {
        let storyboard: UIStoryboard = UIStoryboard(name: "FilterOfWine", bundle: nil)
        guard let controler = storyboard.instantiateViewController(identifier: "FilterOfWineViewController") as? FilterOfWineViewController else { return }
        let viewModel = FilterOfWineViewModel(coordinator: self, filterRelay: filterRelay)
        controler.configure(viewModel: viewModel)
        navigationController?.pushViewController(controler, animated: true)
    }
    
    func navigateHomeScreen() {
        navigationController?.popViewController(animated: false)
    }
}
