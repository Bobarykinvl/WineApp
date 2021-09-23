//
//  RxTableViewCell.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 8.09.21.
//

import RxSwift
import RxCocoa

class RxTableViewCell: UITableViewCell {
    
    private(set) var bag = DisposeBag()
    
    override func prepareForReuse() {
        bag = DisposeBag()
        super.prepareForReuse()
    }
}
