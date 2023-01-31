//
//  MainView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel = CreditScoreViewModel()
    
    func setColor() -> Color{
        if viewModel.getScore() > viewModel.getMaxScore() * 2/3 {
            return .green
        } else if viewModel.getScore() < viewModel.getMaxScore() * 1/3{
            return .red
            
        } else {
            return .orange
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ProgressView().isHidden(!viewModel.isFetchingData || viewModel.networkError)
                Text("An error occured").isHidden(!viewModel.networkError)
                VStack{
                    NavigationLink(
                        destination: DetailsView(viewModel: viewModel),
                        label: {
                            VStack{
                                Text("Your credit score is").font(.title3).padding(4)
                                Text(viewModel.getScore().description)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(setColor())
                                    .padding(4)
                                Text("out of \(viewModel.getMaxScore().description)")
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

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
