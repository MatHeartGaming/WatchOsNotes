//
//  CreditView.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import SwiftUI

struct CreditView: View {
    
    //MARK: - PROPERTIES
    @State private var randomNumber = Int.random(in: 1..<4)
    
    private var randomImage : String {
        return "developer-no\(randomNumber)"
    }
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 3) {
            
            // PROFILE IMAGE
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            // HEADER
            HeaderView(title: "Credits")
            
            // CONTENT
            Text("Mat Buompy")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                //.fontWeight(.light)
            
        } //: VSTACK
    }
}


//MARK: - PREVIEW
struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
