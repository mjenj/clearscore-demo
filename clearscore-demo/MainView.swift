//
//  MainView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = CreditScoreViewModel()
    
    func setColor() -> Color {
        if viewModel.getScore() > viewModel.getMaxScore() * 2/3 {
            return .green
        } else if viewModel.getScore() < viewModel.getMaxScore() * 1/3 {
            return .red
        } else {
            return .orange
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ProgressView().isHidden(!viewModel.isFetchingData || viewModel.networkError)
                Text("ERROR_MESSAGE").isHidden(!viewModel.networkError)
                VStack{
                    NavigationLink(
                        destination: DetailsView(viewModel: viewModel),
                        label: {
                            VStack{
                                Text("CREDIT_TITLE").font(.title3).padding(4)
                                Text(viewModel.getScore().description)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(setColor())
                                    .padding(4)
                                Text("OUT_OF \(viewModel.getMaxScore().description)")
                                    .font(.title3)
                                    .padding(4)
                            }
                        
                        .frame(width: 300, height: 300)
                        .foregroundColor(Color.black)
                        .background(Color.white)
                        .addBorder(Color.gray, cornerRadius: .infinity)
                        .shadow(radius: 10)
                            
                    })
                }.isHidden(viewModel.isFetchingData || viewModel.networkError)
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
