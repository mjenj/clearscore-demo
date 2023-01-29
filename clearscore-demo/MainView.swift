//
//  MainView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = CreditScoreViewModel()
    @State private var hideLoader: Bool? = true
    
    var body: some View {
//        ZStack {
//            Circle()
//                .inset(by: 50)
//                .stroke(Color.blue, lineWidth: 8)
        NavigationView {
            VStack{
                ProgressView().isHidden(hideLoader!)
                NavigationLink(
                    destination: DetailsView(message: viewModel.getScore().description),
                    label: {
                        VStack{
                            Text("Your credit score is")
                            Text(viewModel.getScore().description)
                            Text("out of \(viewModel.getMaxScore().description)")
                        }
                    
                    .frame(width: 300, height: 300)
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .clipShape(Circle())
                        
                })
            }
        }
            
//        }
        .padding()
//        .sheet(isPresented: $presentingSheet, content: {
//            Text("Details View")
//        })
    }
    
    func isLoading(loading: Bool!) {
        hideLoader = loading
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
