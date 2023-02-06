//
//  clearscore_demoUITests.swift
//  clearscore-demoUITests
//
//  Created by Matt Jenje on 2023/01/27.
//

import XCTest

final class clearscore_demoUITests: XCTestCase {
    
    override func setUpWithError() throws {
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScoreDisplayed() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let loader = app.progressIndicators["spinnerView"]
        XCTAssertTrue(loader.isHittable)
        
        let timeout = 2
        let scoreTitle = app.staticTexts["scoreTextView"]
        XCTAssertTrue(scoreTitle.waitForExistence(timeout: TimeInterval(timeout)))
        
        XCTAssertEqual(scoreTitle.label, "514")
        
        let scoreOutOf = app.staticTexts["outOfTextView"]
        XCTAssertTrue(scoreOutOf.waitForExistence(timeout: TimeInterval(timeout)))
        XCTAssertEqual(scoreOutOf.label, "Out of 700")
        
        XCTAssertFalse(loader.isHittable)

    }
}
