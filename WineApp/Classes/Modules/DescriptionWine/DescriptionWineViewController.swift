//
//  DescriptionWineViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 7.08.21.
//

import UIKit
import RxSwift
import RxCocoa

class DescriptionWineViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let viewModel = DescriptionWineViewModel()
    private let bag = DisposeBag()
    private var model: Wine?
    private let fileManager = FileManagerWine()
    private let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func configure(model: Wine) {
        self.model = model
    }
}

// MARK: Setup
extension DescriptionWineViewController {
    
    func setup() {
        
        let locale = Locale(identifier: "en_RU")
        numberFormatter.locale = locale
        numberFormatter.numberStyle = .currency
        
        fileManager.readImageInTmpFolder(by: URL(string: model!.image)!.lastPathComponent).subscribe({
            self.image.image = $0.element
        }).disposed(by: bag)
        
        nameLabel.text = model?.name
        priceLabel.text = self.numberFormatter.string(for:model?.price)
    }
}
