//
//  AddWineViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 12.08.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddWineViewModel {
    
    private let userStorage = RealmStorage()
    private let coordinator: AddWineCoordinator
    private let bag = DisposeBag()
    private let fileManager = FileManagerWine()
    
    init(coordinator: AddWineCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: ViewModelType
extension AddWineViewModel: ViewModelType {
    
    struct Input {
        var imageOfWine: Driver<UIImage>
        var nameOfWine: Driver<String>
        var priceOfWine: Driver<String>
        var addWineTapped: Driver<Void>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        let form = Driver.combineLatest(input.imageOfWine, input.nameOfWine,input.priceOfWine)
        
        input.addWineTapped.withLatestFrom(form).drive(onNext:{[weak self] image, name, price in
            let imagePath = self?.fileManager.saveImageInTmpFolder(image)?.absoluteString
            let wine = Wine(image: imagePath!, name: name, price: Double(price) ?? 0)
            
            self?.userStorage.saveWine(object: wine)
            
            self?.coordinator.navigateHomeScreen()
        }).disposed(by: bag)
        return Output()
    }
}
