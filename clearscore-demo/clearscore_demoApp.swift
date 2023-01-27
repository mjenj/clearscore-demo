//
//  clearscore_demoApp.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import SwiftUI

let url = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"

@main
struct clearscore_demoApp: App {
    
    @State private var mainView: MainView?
        
    init() {
        fetchData()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    func fetchData() {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
        }
        task.resume()
    }
}
