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

    func testBreedSearchRequest() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Test the breead search request
        let expectation = self.expectation(description: "Breeds loaded")
        var breeds:[Breed] = []
        
        
        let networking = Networking()
        networking.searchBreeds(query: "Terrier") { result in
            switch result {
            case .success(let loadedBreeds):
                breeds = loadedBreeds
                expectation.fulfill()
            case .failure(let error):
                
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssert(breeds.count > 0, "Loaded breeds")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
