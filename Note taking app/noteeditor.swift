//
//  texteditor.swift
//  Note taking app
//
//  Created by Yacov Vladimirovich on 7/24/26.
//
import SwiftUI

struct noteeditor: View {
    
    @State public var currentnote = ""
    @AppStorage("savedNotes") private var savedNotesData: Data = Data()
    @State public var notes: [Note]
    //@State private var selectednote: String = ""
    

    //////oooooo mysterious data saver AND loader //////
    
    func saveNotes() {
        if let data = try? JSONEncoder().encode(notes) {
            savedNotesData = data
        }
    }
    
    func loadNotes() {
        if let loadedNotes = try? JSONDecoder().decode(
            [Note].self,
            from: savedNotesData,
        ) {
            notes = loadedNotes
        }
    }
    
    
    ////////////////////////////////////////////////////
    
    
    var body: some View {
        VStack{
            TextEditor(text: $currentnote)
            //(notes, id: \.self){ note in
                .scrollContentBackground(.hidden)
                .background(.ultraThinMaterial)
                .frame(width: 420, height: 550)
                .font(.system(size: 30))
                //.glassEffect(.regular)
                //.background(.gray)
                //.fill(.ultraThinMaterial)
                //.glassEffect(.clear)
                .cornerRadius(30)
                .padding()
            //Spacer()
            //TEXT BOX
        }

    }
}
