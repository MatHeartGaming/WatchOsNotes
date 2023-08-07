//
//  HeaderView.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import SwiftUI

struct HeaderView: View {
    
    //MARK: - PROPERTIES
    var title = ""
    
    
    //MARK: - BODY
    var body: some View {
        VStack {
            
            // TITLE
            if !title.isEmpty {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            
            // SEPARATOR
            
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            } //: HSTACK
            .foregroundColor(.accentColor)
        } //: VSTACK
    }
}

//MARK: - PREVIEW
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Credits")
            
            HeaderView()
        }
    }
}
