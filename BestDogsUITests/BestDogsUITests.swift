//
//  BestDogsUITests.swift
//  BestDogsUITests
//
//  Created by Tim Windsor Brown on 20/09/2021.
//

import XCTest

class BestDogsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadDataAndOpen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        
        let searchField = app.searchFields["Search for dog breed..."]
        searchField.tap()
        searchField.typeText("Terrier")
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews.cells.firstMatch.tap()
        
        XCTAssert(app.staticTexts["Typical lifespan"].exists, "Detail view has opened.")   
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
