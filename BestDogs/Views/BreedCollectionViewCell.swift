//
//  BreedCollectionViewCell.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 23/09/2021.
//

import Foundation
import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    /// IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var breedTitle: UILabel!
    
    static var cellID: String = "BreedCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupView() {
        self.layer.borderColor = CGColor.init(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }


    
    // Binding to setup cell from ViewModel
    var breedResultViewModel:BreedResultViewModel? {
        didSet {
            self.breedTitle.text = breedResultViewModel?.name ?? ""
            if let image = breedResultViewModel?.image {
                self.imageView.image = image
            }
            else {
                self.imageView.image = UIImage(named: "EmptyDogImage")
            }
            self.breedResultViewModel?.imageDidLoadCompletion = { () in
                if let image = self.breedResultViewModel?.image {
                    self.imageView.image = image
                }
            }
        }
    }
}
