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

//Some tests require US Locale
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
    
    func testGetShortTermDebtAsCurrency() throws {
        XCTAssertEqual(viewModel?.getShortTermDebtAsCurrency(), "$13,758.00")
    }
    
    func testGetShortTermCreditLimit() throws {
        XCTAssertEqual(viewModel?.getShortTermCreditLimit(), 30600)
    }
    
    func testGetShortTermCreditLimitAsCurrency() throws {
        XCTAssertEqual(viewModel?.getShortTermCreditLimitAsCurrency(), "$30,600.00")
    }
    
    func testGetPercentageCreditUsed() throws {
        XCTAssertEqual(viewModel?.getPercentageCreditUsed(), 44)
    }
    
    func testGetCurrentLongTermDebt() throws {
        XCTAssertEqual(viewModel?.getCurrentLongTermDebt(), 24682)
    }
    
    func testGetCurrentLongTermDebtAsCurrency() throws {
        XCTAssertEqual(viewModel?.getCurrentLongTermDebtAsCurrency(), "$24,682.00")
    }
    
    func testGetChangeInLongTermDebt() throws {
        XCTAssertEqual(viewModel?.getChangeInLongTermDebt(), -327)
    }
    
    func testGetChangeInLongTermDebtAsCurrency() throws {
        XCTAssertEqual(viewModel?.getChangeInLongTermDebtAsCurrency(), "-$327.00")
    }
    
    func testCurrencyFormatterInt() throws {
        XCTAssertEqual(viewModel?.formatNumberToCurrency(number: 200), "$200.00")
    }
    
    func testCurrencyFormatterDouble() throws {
        XCTAssertEqual(viewModel?.formatNumberToCurrency(number: 3.0), "$3.00")
    }
}
