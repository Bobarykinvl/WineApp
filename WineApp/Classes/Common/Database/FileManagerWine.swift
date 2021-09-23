//
//  FileManager.swift
//  WineApp
//
//  Created by Владислав Бобарыкин on 20.08.21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class FileManagerWine {
    
    private let manager = FileManager.default
    
    func saveImageInTmpFolder(_ image: UIImage) -> URL? {
        let timestampFilename = String(Int(Date().timeIntervalSince1970)) + "Wine.png"
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        print (url)
        let photoPath = url.appendingPathComponent("tmp")
        try? manager.createDirectory(at: photoPath,
                                     withIntermediateDirectories: true,
                                     attributes: nil)
        let path = photoPath.appendingPathComponent(timestampFilename)
        let imageData = image.jpegData(compressionQuality: 0.2)
        manager.createFile(atPath: path.path, contents: imageData, attributes: [.type : "jpg"])
        return path
    }
    
    func readImageInTmpFolder(by fileName: String) ->  Observable<UIImage> {
        
        return Observable<UIImage>.create({ observer in
          
                let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let photoPath = documentsUrl.appendingPathComponent("tmp")
                let fileURL = photoPath.appendingPathComponent(fileName)
                if let imageData = try? Data(contentsOf: fileURL),
                   let image = UIImage(data: imageData) {
                    observer.onNext(image)
                } else {
    //                observer.onError(Error("Error"))
                }
                observer.onCompleted()
                
            return Disposables.create()
        })
        
        
        
        
        

//
//            Observable<UIImage>.create { observer in
//                observer.onNext(UIImage(data: imageData!)!)
//                return Disposables.create()
//            }
//
//
//        return
        }

    
    
    //        var photo: Observable<UIImage> {
    //            return Observable.create { observer in
    //              return Disposables.create()
    //            }
    //        }
            
    //        Observable.create { PublishSubject<UIImage> in
    //
    //        }
    
    
        
    //                DispatchQueue.main.async { }
    
//    let image = UIImage(contentsOfFile: fileURL.absoluteString)
   //        return image
        
//        let pathString = path.absoluteString
//        guard let image = UIImage(contentsOfFile: pathString ) else { return UIImage(systemName: "plus")! }
//        return image
        
//        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
//        let photoPath = documentsUrl.appendingPathComponent("tmp")
//                let fileURL = photoPath.appendingPathComponent(fileName)
//                do {
//                    let imageData = try Data(contentsOf: fileURL)
//                    return UIImage(data: imageData)
//                } catch {}
//                return nil


    
    
    
}
