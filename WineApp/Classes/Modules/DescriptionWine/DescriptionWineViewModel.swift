//
//  DescriptionWineViewModel.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 7.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class DescriptionWineViewModel {
    

}

extension DescriptionWineViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        var dataSource: Driver<Wine>
    }
    
    func transform(input: Input) {
//        let dataSource = Driver.of(Wine(image: "qwe", name: "qwe", price: "qwe"))
//        return Output(dataSource: dataSource)
}
}
