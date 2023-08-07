//
//  ContentView.swift
//  WatchNotes Watch App
//
//  Created by Matteo Buompastore on 07/08/23.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPERTIES
    @AppStorage("lineCount") var lineCount : Int = 1
    @State private var notes = [Note]()
    @State private var text : String = ""
    
    //MARK: - FUNCTIONS
    func save() {
        //dump(notes)
        do {
            // 1. Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new URL to save the fiel using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 3. Write the data to the given URL
            try data.write(to: url)
            
        } catch (let error) {
            print("Saving data has failed \(error)")
        }
    }
    
    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            do {
                // 1. Get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                // 2. Create a new property for the data
                let data = try Data(contentsOf: url)
                
                try withAnimation(.spring()) {
                    // 3. Decode the data
                    notes = try JSONDecoder().decode([Note].self, from: data)
                }
                
            } catch (let error) {
                print("Failed to load notes \(error)")
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func delete(offsets : IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("add New note", text: $text)
                    
                    Button {
                        //MARK: - ACTION ADD NOTE
                        // 1. Only run the button's action when the field is not empty
                        guard text.isEmpty == false else {return}
                        
                        // 2. Create a new note item and initialize it with the text value
                        let note = Note(id: UUID(), text: text)
                        
                        // 3. Add teh new note item to the notes array
                        notes.append(note)
                        
                        // 4. Clear the text field
                        text = ""
                        
                        // 5. Save the notes (function)
                        save()
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(.plain)
                    .foregroundColor(.accentColor)
                    //.tint(.accentColor)
                    
                } //: HSTACK
                
                Spacer()
                
                if !notes.isEmpty{
                    List {
                        ForEach(0 ..< notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailVIew(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                } //: HSTACK
                            } //: NAVIGATION
                        } //: LOOP
                        .onDelete(perform: delete)
                        .animation(.easeIn, value: notes.isEmpty)
                    } //: LIST
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(25)
                        .animation(.spring(), value: notes.isEmpty)
                    Spacer()
                } //: LIST
                
            } //: VSTACK
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                load()
        }
        }
    }
}


//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
