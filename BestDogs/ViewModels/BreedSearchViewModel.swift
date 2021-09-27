//
//  BreedSearchViewModel.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 23/09/2021.
//

import Foundation

/// Model view that insulates the viewcontroller
/// from the model.
class BreedSearchViewModel {
    
    enum SearchStatus {
        case NoSearch, Searching, Results, Empty
    }
    
    private var breedResults:[Breed] = []
    private var breedResultViewModels:[BreedResultViewModel] = [] {
        didSet {
            self.reloadResultsCollectionView?()
        }
    }
    
    // Binding interface closures
    var currentSearchStatus:SearchStatus = .NoSearch {
        didSet {
            self.updateSearchStatus?(currentSearchStatus)
        }
    }
    
    var numberOfCells:Int {
        return self.breedResultViewModels.count
    }
    
    func breedResultViewModel(forIndexPath indexPath:IndexPath) -> BreedResultViewModel? {
        let index = indexPath.row
        if self.breedResultViewModels.count > index {
            return self.breedResultViewModels[index]
        }
        return nil
    }
    
    func breedDetailViewModel(forIndexPath indexPath:IndexPath) -> BreedDetailViewModel? {
        let index = indexPath.row
        if self.breedResults.count > index {
            let breedDetailVM = BreedDetailViewModel(breed: self.breedResults[index])
            return breedDetailVM
        }
        return nil
    }
    
    // Completion blocks to be set by the VC
    var reloadResultsCollectionView:(()->())?
    var showAlert:((_ alertTitle:String, _ alertMessage: String)->())?
    var updateSearchStatus:((_ searchStatus:SearchStatus)->())?
    
    
    
    /// Utilites
    func searchForBreed(query:String) {
        
        self.currentSearchStatus = .Searching
        
        let networking = Networking()
        networking.searchBreeds(query: query) { result in
            
            switch result {
            case .success(let breeds):
                
                self.currentSearchStatus = (breeds.count > 0) ? .Results : .Empty
                self.breedResults = breeds
                var resultViewModels:[BreedResultViewModel] = []
                
                for breed in breeds {
                    let breedVM = BreedResultViewModel(breed: breed)
                    resultViewModels.append(breedVM)
                }
                
                self.breedResultViewModels = resultViewModels
                
                
            case .failure(let error):
                self.currentSearchStatus = .NoSearch
                debugPrint(error)
                self.showAlert?("Woof!", "Error loading breeds, check your connection and try again.")
                            
            }
        }
    }
}
