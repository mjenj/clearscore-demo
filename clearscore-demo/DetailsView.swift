//
//  DetailsView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import Foundation
import SwiftUI

struct DetailsView: View {
    var viewModel: CreditScoreViewModel
    
    var body: some View {
        ScrollView {
            
            Spacer().frame(height: 50)
            
            ZStack {
              RoundedRectangle(cornerRadius: 20)
                .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                .frame(width: 300, height: 200)
                .background(SwiftUI.Color.white)
                
                VStack {
                    Text("CREDIT_USED")
                        .font(.title2)
                    
                    Spacer().frame(height: 20)
                    
                    Text(viewModel.getShortTermCredit().description).padding(4).font(.title2)
                    Text ("OF").foregroundColor(.gray).italic() +
                    Text(viewModel.getShortTermCreditLimit().description).foregroundColor(.gray)
   
                    Spacer().frame(height: 20)
                    
                    Text("\(viewModel.getPercentageCreditUsed().description) USED")
                        .foregroundColor(viewModel.getPercentageCreditUsed() < 50 ? .green : .orange)
                }.frame(height: 60).padding([.bottom], 12)
            }
            
            Spacer().frame(height: 50)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                    .frame(width: 300, height: 200)
                    .background(SwiftUI.Color.white)
                VStack {
                    VStack {
                        Text("OWE_LOANS")
                            .font(.title2)
                    }
                    VStack {
                        Text("\(viewModel.getCurrentLongTermDebt().description)").font(.title2).padding(12)
                        Group {
                            Text("WHICH_IS") +
                            Text(viewModel.getChangeInLongTermDebt().description)
                                .foregroundColor(viewModel.getChangeInLongTermDebt() >= 0.0 ? .red : .green) +
                            Text("CHANGE_FROM")
                        }.frame(width: 250)
                            .multilineTextAlignment(.center)
                    }
                }.frame(height: 200)
            }
            
            
            
        }.padding(18)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: CreditScoreViewModel())
    }
}
