//
//  FilterOfWineController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 22.08.21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FilterOfWineViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    private var viewModel: FilterOfWineViewModel?
    private let bag = DisposeBag()
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func configure(viewModel: FilterOfWineViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: Binding
extension FilterOfWineViewController {
    
    func bind() {
        
        let input = FilterOfWineViewModel.Input(choosedFilter: collectionView.rx.modelSelected(String.self).map { Filter(rawValue: $0) ?? .date
        }.asDriver(onErrorJustReturn: Filter.date))
        
        let output = viewModel?.transform(input: input)
        output?.dataSource.drive(collectionView.rx.items(cellIdentifier: "Cell")) { row,element,cell in
            if let cell = cell as? FilterOfWineCollectionViewCell {
                cell.nameOfFilter.text = element
            }
        }.disposed(by: bag)
    }
}

    

