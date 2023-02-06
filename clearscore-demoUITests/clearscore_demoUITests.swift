//
//  clearscore_demoUITests.swift
//  clearscore-demoUITests
//
//  Created by Matt Jenje on 2023/01/27.
//

import XCTest
@testable import clearscore_demo

let testJson =
"""
 {"accountIDVStatus":"PASS","creditReportInfo":{"score":514,"scoreBand":4,"clientRef":"CS-SED-655426-708782","status":"MATCH","maxScoreValue":700,"minScoreValue":0,"monthsSinceLastDefaulted":-1,"hasEverDefaulted":false,"monthsSinceLastDelinquent":1,"hasEverBeenDelinquent":true,"percentageCreditUsed":44,"percentageCreditUsedDirectionFlag":1,"changedScore":0,"currentShortTermDebt":13758,"currentShortTermNonPromotionalDebt":13758,"currentShortTermCreditLimit":30600,"currentShortTermCreditUtilisation":44,"changeInShortTermDebt":549,"currentLongTermDebt":24682,"currentLongTermNonPromotionalDebt":24682,"currentLongTermCreditLimit":null,"currentLongTermCreditUtilisation":null,"changeInLongTermDebt":-327,"numPositiveScoreFactors":9,"numNegativeScoreFactors":0,"equifaxScoreBand":4,"equifaxScoreBandDescription":"Excellent","daysUntilNextReport":9},"dashboardStatus":"PASS","personaType":"INEXPERIENCED","coachingSummary":{"activeTodo":false,"activeChat":true,"numberOfTodoItems":0,"numberOfCompletedTodoItems":0,"selected":true},"augmentedCreditScore":null}
"""

final class clearscore_demoUITests: XCTestCase {
    
    var data: Data? = nil
    var viewModel: CreditScoreViewModel? = nil

    override func setUpWithError() throws {

        data = Data(testJson.utf8)
        viewModel = CreditScoreViewModel()
        _ = viewModel?.parse(json: data!)
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScoreColour() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let timeout = 2
        let scoreTitle = app.textViews["scoreTextView"]
        XCTAssertTrue(scoreTitle.waitForExistence(timeout: TimeInterval(timeout)))
        XCTAssertEqual(scoreTitle.value as! String , "514")

        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
