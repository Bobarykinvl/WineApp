//
//  HomeViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import RxSwift
import RxCocoa

class HomeViewModel {
        
    private var filter: Filter = Filter.date
    private let userStorage = RealmStorage()
    private let coordinator: HomeCoordinator
    private let bag = DisposeBag()
    private var sort = true
    
    private let filterRelay = BehaviorRelay<Filter>(value: .date)
//    private let sortingRelay = BehaviorRelay<Bool>(value: true)
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: ViewModelType
extension HomeViewModel: ViewModelType {
    
    struct Input {
        var addWineScreenOpen: Driver<Void>
        var filterWineScreenOpen: Driver<Void>
        var selectedModel: Driver<Wine>
        var sorting: Driver<Void>
    }
    
    struct Output {
        var dataSource: Driver<[Wine]>
    }
    
    func transform(input: Input) -> Output {
        input.filterWineScreenOpen.drive(onNext: { [weak self] in
            self?.coordinator.navigateFilterWineScreen(filterRelay: self!.filterRelay)
        }).disposed(by: bag)
        
        input.addWineScreenOpen.drive(onNext: { [weak self] in
            self?.coordinator.navigateAddWineScreen()
        }).disposed(by: bag)
        
        let sorting = input.sorting.scan(true) { lastState, _ in
            !lastState
        }.startWith(false)
        
        let dataSource = Driver.combineLatest(
            filterRelay.asDriver(onErrorJustReturn: .date), userStorage.getListOfWine(), sorting).map { filter, wines, sort -> [Wine] in
                switch filter {
                case .price where sort == true:
                    return wines.sorted {$0.price > $1.price}
                case .name where sort == true:
                    return wines.sorted {$0.name > $1.name}
                case .date where sort == true:
                    return wines.sorted {$0.name > $1.name}
                case .price:
                    return wines.sorted {$0.price < $1.price}
                case .name:
                    return wines.sorted {$0.name < $1.name}
                case .date:
                    return wines.sorted {$0.name < $1.name}
                }
            }
        
        input.selectedModel.drive(onNext: { [weak self] model in
            self?.coordinator.navigateDescriptionWineScreen(model: model)
        }).disposed(by: bag)
        
            return Output(dataSource: dataSource)
    }
}

