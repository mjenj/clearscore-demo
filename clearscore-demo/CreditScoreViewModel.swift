//
//  CreditScoreViewModel.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/29.
//

import Foundation

let requestUrl = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"

class CreditScoreViewModel: ObservableObject {
    @Published var isFetchingData: Bool = true
    @Published var networkError: Bool = false
    @Published var stringData: String?
    @Published var creditScore: CreditScore?
    
    init() {
        self.fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        // Used for testing purposes
        if creditScore != nil { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
                DispatchQueue.main.async{
                    _ = self.parse(json: data)
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
    
    //MARK: String return functions
    
    func getShortTermDebtAsCurrency() -> String {
        return formatNumberToCurrency(number: getShortTermDebt() as NSNumber)
    }
    
    func getShortTermCreditLimitAsCurrency() -> String {
        return formatNumberToCurrency(number: getShortTermCreditLimit() as NSNumber)
    }
    
    func getCurrentLongTermDebtAsCurrency() -> String {
        return formatNumberToCurrency(number: getCurrentLongTermDebt() as NSNumber)
    }
    
    func getChangeInLongTermDebtAsCurrency() -> String {
        return formatNumberToCurrency(number: getChangeInLongTermDebt() as NSNumber)
    }
    
    //MARK: Unwrapping functions
    
    func getScore() -> Int {
        return creditScore?.creditReportInfo.score ?? -1
    }
    
    func getMaxScore() -> Int {
        return creditScore?.creditReportInfo.maxScoreValue ?? -1
    }
    
    func getShortTermDebt() -> Double {
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
    
    func formatNumberToCurrency(number: NSNumber) -> String {
        return NumberFormatter.localizedString(from: number, number: .currency)
    }
    
    func parse(json: Data) -> Bool {
        var dataParsed = false
        
        do {
            let response = try JSONDecoder().decode(CreditScore.self, from: json)
            creditScore = response
            dataParsed = true
        } catch {
            dataParsed = false
            print(error)
        }
        return dataParsed
    }
}
