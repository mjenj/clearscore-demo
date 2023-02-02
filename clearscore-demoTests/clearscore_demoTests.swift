//
//  clearscore_demoTests.swift
//  clearscore-demoTests
//
//  Created by Matt Jenje on 2023/01/27.
//

import XCTest
@testable import clearscore_demo

let testJson =
"""
 {"accountIDVStatus":"PASS","creditReportInfo":{"score":514,"scoreBand":4,"clientRef":"CS-SED-655426-708782","status":"MATCH","maxScoreValue":700,"minScoreValue":0,"monthsSinceLastDefaulted":-1,"hasEverDefaulted":false,"monthsSinceLastDelinquent":1,"hasEverBeenDelinquent":true,"percentageCreditUsed":44,"percentageCreditUsedDirectionFlag":1,"changedScore":0,"currentShortTermDebt":13758,"currentShortTermNonPromotionalDebt":13758,"currentShortTermCreditLimit":30600,"currentShortTermCreditUtilisation":44,"changeInShortTermDebt":549,"currentLongTermDebt":24682,"currentLongTermNonPromotionalDebt":24682,"currentLongTermCreditLimit":null,"currentLongTermCreditUtilisation":null,"changeInLongTermDebt":-327,"numPositiveScoreFactors":9,"numNegativeScoreFactors":0,"equifaxScoreBand":4,"equifaxScoreBandDescription":"Excellent","daysUntilNextReport":9},"dashboardStatus":"PASS","personaType":"INEXPERIENCED","coachingSummary":{"activeTodo":false,"activeChat":true,"numberOfTodoItems":0,"numberOfCompletedTodoItems":0,"selected":true},"augmentedCreditScore":null}
"""

final class clearscore_demoTests: XCTestCase {
    
    var data: Data? = nil
    var viewModel: CreditScoreViewModel? = nil

    override func setUpWithError() throws {
        data = Data(testJson.utf8)
        viewModel = CreditScoreViewModel()
        _ = viewModel?.parse(json: data!)
    }

    override func tearDownWithError() throws {
        data = nil
        viewModel = nil
    }

    func testDataParsingGoodData() throws {
        XCTAssertTrue(viewModel?.parse(json: data!) ?? false)
    }
    
    func testDataParsingBadData() throws {
        data = Data("{\"accountIDVStatus\":\"PASS\",\"creditReportInfo\"}".utf8)
        XCTAssertFalse(viewModel?.parse(json: data!) ?? false)
    }
    
    func testGetScore() throws {
        XCTAssertEqual(viewModel?.getScore(), 514)
    }
    
    func testGetMaxScore() throws {
        XCTAssertEqual(viewModel?.getMaxScore(), 700)
    }
    
    func testGetShortTermDebt() throws {
        XCTAssertEqual(viewModel?.getShortTermDebt(), 13758)
    }
    
    func testGetShortTermCreditLimit() throws {
        XCTAssertEqual(viewModel?.getShortTermCreditLimit(), 30600)
    }
    
    func testGetPercentageCreditUsed() throws {
        XCTAssertEqual(viewModel?.getPercentageCreditUsed(), 44)
    }
    
    func testGetCurrentLongTermDebt() throws {
        XCTAssertEqual(viewModel?.getCurrentLongTermDebt(), 24682)
    }
    
    func testGetChangeInLongTermDebt() throws {
        XCTAssertEqual(viewModel?.getChangeInLongTermDebt(), -327)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
