//
//  BreedResultViewModel.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 25/09/2021.
//

import Foundation
import UIKit

class BreedResultViewModel {
    let name:String?
    let imageRef:String?
    var image:UIImage? = nil {
        didSet {
            if image != nil {
                self.imageDidLoadCompletion?()
            }
        }
    }
    var imageDidLoadCompletion:(()->())?
    
    init(breed:Breed) {
        name = breed.name
        imageRef = breed.imageRef
        
        loadImage()
    }
    
    
    func loadImage() {
        
        if let imageRef = imageRef {
            let networking = Networking()
            networking.fetchImage(imageRef: imageRef) { result in
                switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}
