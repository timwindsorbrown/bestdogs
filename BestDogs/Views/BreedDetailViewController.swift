//
//  BreedDetailViewController.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 26/09/2021.
//

import Foundation
import UIKit

class BreedDetailViewController: UIViewController {
    
    @IBOutlet var breedImageView:UIImageView!
    @IBOutlet var breedTitleLabel:UILabel!
    @IBOutlet var breedTemperamentLabel:UILabel!
    @IBOutlet var typicalLifespanTitleLabel:UILabel!
    @IBOutlet var typicalLifespanLabel:UILabel!
    @IBOutlet var originalBreedingTitleLabel:UILabel!
    @IBOutlet var originalBreedingLabel:UILabel!
    
    var breedDetailViewModel:BreedDetailViewModel?
    
    override func viewDidLoad() {
        
        setupView()
        super.viewDidLoad()
    }

    func setupView() {
        if let image = self.breedDetailViewModel?.image {
            self.breedImageView.image = image
        }
        self.breedTitleLabel.text = breedDetailViewModel?.name ?? ""
        self.breedTemperamentLabel.text = breedDetailViewModel?.temperament ?? ""
        self.typicalLifespanLabel.text = breedDetailViewModel?.lifespan ?? "N/A"
        self.originalBreedingLabel.text = breedDetailViewModel?.originalBreeding ?? "N/A"
        
        self.breedDetailViewModel?.imageDidLoadCompletion = { () in
            self.breedImageView.image = self.breedDetailViewModel?.image
        }
    }
}
