//
//  CreditScore.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/29.
//

import Foundation


struct CreditScore: Codable {
    var accountIDVStatus: String
    var creditReportInfo: CreditReportInfo
    var dashboardStatus: String
    var personaType: String
    var coachingSummary: CoachingSummary
    var augmentedCreditScore: String?
}

struct CreditReportInfo: Codable {
    var score: Int
    var scoreBand: Int
    var clientRef: String
    var status: String
    var maxScoreValue: Int
    var minScoreValue: Int
    var monthsSinceLastDefaulted: Int
    var hasEverDefaulted: Bool
    var monthsSinceLastDelinquent: Int
    var hasEverBeenDelinquent: Bool
    var percentageCreditUsed: Int
    var percentageCreditUsedDirectionFlag: Int
    var changedScore: Int
    var currentShortTermDebt: Double
    var currentShortTermNonPromotionalDebt: Double
    var currentShortTermCreditLimit: Double
    var currentShortTermCreditUtilisation: Double
    var changeInShortTermDebt: Double
    var currentLongTermDebt: Double
    var currentLongTermNonPromotionalDebt: Double
    var currentLongTermCreditLimit: Double?
    var currentLongTermCreditUtilisation: Double?
    var changeInLongTermDebt: Double
    var numPositiveScoreFactors: Int
    var numNegativeScoreFactors: Int
    var equifaxScoreBand: Int
    var equifaxScoreBandDescription: String
    var daysUntilNextReport: Int
}

struct CoachingSummary: Codable {
    var activeTodo: Bool
    var activeChat: Bool
    var numberOfTodoItems: Int
    var numberOfCompletedTodoItems: Int
    var selected: Bool
}
