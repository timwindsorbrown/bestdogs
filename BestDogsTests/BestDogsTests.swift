//
//  BestDogsTests.swift
//  BestDogsTests
//
//  Created by Tim Windsor Brown on 20/09/2021.
//

import XCTest
@testable import BestDogs


class BestDogsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test the breead search request contains results,
    // and that the first contains a name
    func testBreedSearchRequest() throws {
        let loadedBreedsExpectation = self.expectation(description: "Breeds loaded")
        let validBreedExpectation = self.expectation(description: "Valid breed")
        var breeds:[Breed] = []
        
        let networking = Networking()
        networking.searchBreeds(query: "Terrier") { result in
            switch result {
            case .success(let loadedBreeds):
                breeds = loadedBreeds
                if breeds.count > 0 {
                    loadedBreedsExpectation.fulfill()
                    if breeds.first?.name != nil {
                        validBreedExpectation.fulfill()
                    }
                }
            case .failure( _):
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoadingImages() throws {
        
        let loadedImageExpectation = self.expectation(description: "Image loaded")

        let breedDetailVM = BreedDetailViewModel(breed: Breed(bredFor: "1", breedGroup: "2", id: 0, imageRef: "3", lifeSpan: "4", name: "5", origin: "6", temperament: "7") )
        breedDetailVM.loadImage(imageRef: "B12BnxcVQ") { image in
            debugPrint(image.debugDescription)
            if image != nil {
                loadedImageExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
