//
//  WineTableViewCell.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 6.08.21.
//

import UIKit
import RxCocoa
import RxSwift

class WineTableViewCell: RxTableViewCell {
    
    private let fileManager = FileManagerWine()
    private let numberFormatter = NumberFormatter()

    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(wine: Wine) {
        
        let locale = Locale(identifier: "en_RU")
        numberFormatter.locale = locale
        numberFormatter.numberStyle = .currency
       
        
        
        self.fileManager.readImageInTmpFolder(by: URL(string: wine.image)!.lastPathComponent).observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background)).bind(to: wineImageView.rx.image).disposed(by: bag)
        
        nameLabel.text = wine.name
        priceLabel.text = self.numberFormatter.string(for: wine.price)
    }
}

