//
//  DetailVIew.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import SwiftUI

struct DetailVIew: View {
    
    //MARK: - PROPERTIES
    let note : Note
    let count : Int
    let index : Int
    
    @AppStorage("lineCount") var lineCount : Int = 1
    @State private var isCreditPresented = false
    @State private var isSettingsPresented = false
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            
            // HEADER
            HeaderView()
            
            // CONTENT
            Spacer()
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            // FOOTER
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditPresented.toggle()
                    }
            } //: HSTACK
            .foregroundColor(.secondary)
            
        } //: VSTACK
        .padding(4)
        .sheet(isPresented: $isCreditPresented) {
            CreditView()
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
    }
}


//MARK: - PREVIEW
struct DetailVIew_Previews: PreviewProvider {
    static var previews: some View {
        DetailVIew(note: Note(id: UUID(), text: "Note..."), count: 1, index: 1)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
