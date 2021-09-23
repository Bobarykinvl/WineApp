//
//  FilterOfWineViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import RxSwift
import RxCocoa

class FilterOfWineViewModel {
    
    var filter = ["Filter by price", "Filter by name", "Filter by date"]
    
    private let coordinator: FilterOfWineCoordinator
    private let bag = DisposeBag()
    private let filterRelay: BehaviorRelay<Filter>
    
    init(coordinator: FilterOfWineCoordinator, filterRelay: BehaviorRelay<Filter>) {
        self.coordinator = coordinator
        self.filterRelay = filterRelay
    }
}

extension FilterOfWineViewModel: ViewModelType {
    
    struct Input {
        var choosedFilter: Driver<Filter>
    }
    
    struct Output {
        var dataSource: Driver<[String]>
//        var choosedFilter: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        input.choosedFilter.drive { [weak self] filter in
            self?.filterRelay.accept(filter)
            self?.coordinator.navigateHomeScreen()
        }.disposed(by: bag)
        
        let dataSource = Driver.just(filter)
        return Output(dataSource: dataSource)
    }
}
