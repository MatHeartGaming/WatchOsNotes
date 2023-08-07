//
//  SettingsView.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - PROPERTIES
    @AppStorage("lineCount") var lineCount : Int = 1
    @State private var sliderValue : Float = 1
    
    //MARK: - FUNCTIONS
    func update() {
        lineCount = Int(sliderValue)
    }
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 8) {
            // HEADER
            HeaderView(title: "Settings")
            
            // ACTUAL LINE COUNT
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.semibold)
            
            // SLIDER
            Slider(value: Binding(get: {
                Double(self.lineCount)
            }, set: { newValue, _ in
                self.sliderValue = Float(newValue)
                self.update()
            }), in: 1...4, step: 1)
                .tint(.accentColor)
        } //: VSTACK
    }
}


//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
