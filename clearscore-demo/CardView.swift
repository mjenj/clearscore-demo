//
//  CardView.swift
//  clearscore-demo
//
//  Created by Matt Jenje on 2023/02/05.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
            .frame(width: 300, height: 200)
            .background(SwiftUI.Color.white)
    
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
