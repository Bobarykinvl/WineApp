//
//  ViewModelType.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 4.08.21.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
