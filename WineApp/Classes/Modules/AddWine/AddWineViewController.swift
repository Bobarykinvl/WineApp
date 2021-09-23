//
//  AddWineViewController.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 12.08.21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class AddWineViewController: UIViewController {
    
    @IBOutlet fileprivate weak var addImageOfWine: UIImageView!
    @IBOutlet private weak var addNameOfWineField: UITextField!
    @IBOutlet private weak var addPriceOfWineField: UITextField!
    @IBOutlet private weak var addNewWine: UIButton!
    @IBOutlet fileprivate weak var addImageOfWineButton: UIButton!
    
    private let imageRelay = PublishRelay<UIImage>()
    private let picker = UIImagePickerController()
    private var viewModel: AddWineViewModel?
    private let fileManager = FileManagerWine()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func configure(viewModel: AddWineViewModel) {
        self.viewModel = viewModel
    }
    
    @IBAction func AddPhoto(_ sender: Any) {
        picker.delegate = self
        picker.allowsEditing = true
        selectMediaSource()
    }
}

// MARK: UIImagePickerControllerDelegate
extension AddWineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            addImageOfWine.image = image
            imageRelay.accept(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: Binding
extension AddWineViewController {
    
    func bind() {
        let input = AddWineViewModel.Input.init(imageOfWine: imageRelay.asDriver(onErrorJustReturn: UIImage()), nameOfWine: addNameOfWineField.rx.text.map { $0 ?? ""}.asDriver(onErrorJustReturn:""), priceOfWine: addPriceOfWineField.rx.text.map { $0 ?? ""}.asDriver(onErrorJustReturn:""), addWineTapped: addNewWine.rx.tap.asDriver())
        
        guard let viewModel = viewModel else { return }
        _ = viewModel.transform(input: input)
    }
}

// MARK: Select media source
extension AddWineViewController {
    
    func selectMediaSource() {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            self.picker.sourceType = .camera
            self.navigationController?.present(self.picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.picker.sourceType = .photoLibrary
            self.navigationController?.present(self.picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.navigationController?.present(actionSheet, animated: true, completion: nil)
    }
}

//extension Reactive where Base: AddWineViewController {
//
//    var uploadImage: Signal<Void> {
//        base.addImageOfWineButton.rx.tap.asSignal()
//    }
//
//    var newImage: Binder<UIImage?> {
//        Binder(base) { view, image in
//            view.addImageOfWine.image = image
//        }
//    }
//}
