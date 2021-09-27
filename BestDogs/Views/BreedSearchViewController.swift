//
//  BreedSearchViewController.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 22/09/2021.
//

import Foundation
import UIKit

class BreedSearchViewController: UIViewController {
    
        
    // Outlets
    @IBOutlet var resultsCollectionView: UICollectionView!
    @IBOutlet var statusLabel:UILabel!
    @IBOutlet var searchBar:UISearchBar!

    // Variables
    var breedSearchViewModel:BreedSearchViewModel?
    
    override func viewDidLoad() {
                
        self.setupViewModels()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        // TODO: auto search on launch for testing
//        self.searchBar.text = "terrier"
//        self.searchBarSearchButtonClicked(self.searchBar)
        super.viewDidAppear(animated)
    }
    
    // Setup Functions
    func setupViewModels() {
        self.breedSearchViewModel = BreedSearchViewModel()
        
        self.breedSearchViewModel?.showAlert = { (alertTitle, alertMessage) in
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.breedSearchViewModel?.updateSearchStatus = { (searchStatus) in
            
            switch searchStatus {
            case .NoSearch:
                self.statusLabel.text = "Search for breeds."
            case .Empty:
                self.statusLabel.text = "No breeds for that search!"
            case .Results:
                self.statusLabel.text = ""
            case .Searching:
                self.statusLabel.text = "Searching..."
            }
            
            UIView.animate(withDuration: 0.2) {
                self.resultsCollectionView.alpha = searchStatus == .Results ? 1 : 0
            }
        }
        
        self.breedSearchViewModel?.reloadResultsCollectionView = { () in
            self.resultsCollectionView.reloadData()
        }
    }
    
}


// Search bar delegate
extension BreedSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let queryString = searchBar.text ?? ""
        if queryString.count > 0 {
            searchBar.resignFirstResponder()
            self.breedSearchViewModel?.searchForBreed(query: queryString)
        }
    }
}

// Collection View Delegates
extension BreedSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.breedSearchViewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Create cell from viewModel
        if let resultViewModel = self.breedSearchViewModel?.breedResultViewModel(forIndexPath: indexPath) {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.cellID, for: indexPath) as? BreedCollectionViewCell {
                cell.breedResultViewModel = resultViewModel
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let breedDetailVM = self.breedSearchViewModel?.breedDetailViewModel(forIndexPath: indexPath) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let breedDetailVC = storyboard.instantiateViewController(withIdentifier: "BreedDetailViewController") as? BreedDetailViewController {
                
                breedDetailVC.breedDetailViewModel = breedDetailVM
                
                self.present(breedDetailVC, animated: true, completion: nil)
            }
        }
    }
}
