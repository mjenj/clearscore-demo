//
//  ContentView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        ZStack {
//            Circle()
//                .inset(by: 50)
//                .stroke(Color.blue, lineWidth: 8)
            VStack{
                Button(action: {
                    
                }){
                    VStack{
                        Text("Your credit score is")
                        Text("300")
                        Text("out of 700")
                    }
                    .frame(width: 300, height: 300)
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .clipShape(Circle())
                }
            }
//        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
