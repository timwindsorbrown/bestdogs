//
//  BreedDetailViewModel.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 26/09/2021.
//

import Foundation
import UIKit

class BreedDetailViewModel {
    
    let name:String?
    let imageRef:String?
    var image:UIImage? = nil {
        didSet {
            if image != nil {
                self.imageDidLoadCompletion?()
            }
        }
    }
    let temperament:String?
    let lifespan:String?
    let originalBreeding:String?
    
    var imageDidLoadCompletion:(()->())?
    
    init(breed:Breed) {
        self.name = breed.name
        self.imageRef = breed.imageRef
        self.temperament = breed.temperament
        self.lifespan = breed.lifeSpan
        self.originalBreeding = breed.bredFor
        
        self.loadImage()
    }
    
    
    func loadImage() {
        
        if self.image == nil {
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
}
