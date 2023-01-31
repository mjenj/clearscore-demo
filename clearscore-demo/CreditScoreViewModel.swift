//
//  CreditScoreViewModel.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/29.
//

import Foundation

let url = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"

class CreditScoreViewModel: ObservableObject {
    @Published var isFetchingData: Bool = true
    @Published var networkError: Bool = false
    @Published var stringData: String?
    @Published var creditScore: CreditScore?
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
                DispatchQueue.main.async{
                    self.parse(json: data)
                    self.stringData = string
                    self.isFetchingData = false
                }
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async{
                    self.networkError = true
                }
            }
        }
        task.resume()
    }
    
    func getScore() -> Int {
        return creditScore?.creditReportInfo.score ?? -1
    }
    
    func getMaxScore() -> Int {
        return creditScore?.creditReportInfo.maxScoreValue ?? -1
    }
    
    func getShortTermCredit() -> Double {
        return creditScore?.creditReportInfo.currentShortTermDebt ?? -1
    }
    
    func getShortTermCreditLimit() -> Double {
        return creditScore?.creditReportInfo.currentShortTermCreditLimit ?? -1
    }
    
    func getPercentageCreditUsed() -> Int {
        return creditScore?.creditReportInfo.percentageCreditUsed ?? -1
    }
    
    func getCurrentLongTermDebt() -> Double {
        return creditScore?.creditReportInfo.currentLongTermDebt ?? -1
    }
    
    func getChangeInLongTermDebt() -> Double {
        return creditScore?.creditReportInfo.changeInLongTermDebt ?? -1
    }
    
    func parse(json: Data) {
        
        do {
            let response = try JSONDecoder().decode(CreditScore.self, from: json)
            creditScore = response
        } catch {
            print(error)
        }
    }
}
