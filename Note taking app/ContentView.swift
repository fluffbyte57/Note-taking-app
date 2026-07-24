//
//  ContentView.swift
//  Note taking app
//
//  Created by Yacov Vladimirovich on 7/21/26.
//  ooooo cool project awesome sauce

// REMINDERSSSSSSSSS


// name change button NEXT TO the name of a currently saved ntoe
// overwrite saved notes, not create copies of em
// date last edited next to a note
// share a note OR AT LEAST FOR NOW copy paste the text

///////////////////////////////////////////////////////

// Nevermind now i know how to commit, i'm a genius

import SwiftUI

struct ContentView: View {

    @State private var currentnote = ""
    @State private var currentNoteName = ""
    @AppStorage("savedNotes") private var savedNotesData: Data = Data()

    @State private var notes: [Note] = []
    //@State private var selectednote: String = ""

    @State private var selectedNoteID: UUID?
    
    //.preferredColorScheme(darkMode? .dark : .light)
    @AppStorage("darkMode") private var darkMode = false
    
    
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
        //.preferredColorScheme(darkMode ? .dark : .light)
        //preferredColorScheme(darkMode ? .dark : .light)
        //preferredColorScheme(.dark)
        VStack{
            HStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                        .frame(width: 100 , height: 50)
                    HStack(spacing: 10){
                        Button{
                           // print("Deleted the current note")
                            
                            if let selectedNoteID,
                               let index = notes.firstIndex(where: {$0.id == selectedNoteID }) {
                                print("remobing " , index)
                                notes.remove(at: index)
                                saveNotes()
                                
                                currentnote = ""
                                currentNoteName = ""
                                self.selectedNoteID = nil
                            }
                            
                            saveNotes()
                            currentnote = ""
                                  // along with deleting current "note" and text in it, also show a text label as saying "no notes currently selected" and have it always be visible unless the TextEditor is overlaying it
                        } label: {
                            Image(systemName: "trash")
                                .glassEffect()
                                .font(.system(size: 30))
                        }
                        Button{
                            print("darkmode state: ", darkMode)
                            darkMode.toggle()
                            //dark | light mode switcher!!
                        } label: {
                            Image(systemName: darkMode ? "sun.max.fill" : "moon")
                                .glassEffect()
                                .font(.system(size: 35))
                        }
                    }

                }
                Text("Note taker")
                    .font(.title)
                    .bold()
                    .italic()
                    .padding()
                    .lineLimit(1)
                    .layoutPriority(1)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                        .frame(width: 100 , height: 50)
                    HStack(spacing: 10){
                        Button{

                            if let selectedNoteID,
                               let index = notes.firstIndex(where: { $0.id == selectedNoteID }) {

                                notes[index].text = currentnote
                                notes[index].name = currentNoteName

                            } else {
                                let newNote = Note(
                                    id: UUID(),
                                    name: currentNoteName,
                                    text: currentnote
                                )

                                notes.append(newNote)
                                selectedNoteID = newNote.id
                            }

                            saveNotes()
                            //ILL MAKE THIS THE SHARING BUTTON
                        } label: {
                            
                            Image(systemName: "square.and.arrow.down")
                                .glassEffect()
                                .font(.system(size: 35))
                            // note from database thats selected (selectednote)
                            // whats in the text editor (currentnote)
                            // the database (notes)
                        }
                        Button{
                            let newNote = Note(
                                id: UUID(),
                                name: "Untitled Note",
                                text: currentnote
                            )
                            
                            notes.append(newNote)
                            saveNotes()
                        } label: {
                            Image(systemName: "plus")
                                .glassEffect()
                                .font(.system(size: 40))
                        }
                    }

                }
                Spacer()
            }
            //TOP AND TITLE HERE
        }

        //for the record i effing hate this
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
        
        
        VStack{
            Text("Recents")
                .bold()
                .font(.title3)
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
                ScrollView{
                    VStack(spacing: 5){
                        ForEach(notes){ note in
                            Button{
                                print("loading note")
                                currentnote = note.text
                                currentNoteName = note.name
                                selectedNoteID = note.id
                            } label: {
                                Text(note.name)
                                //i spent 30 minutes figuring out what tf was going on and i had the text set to note.text instead of note.name im so stupid
                                    //.padding()
                                    .lineLimit(1)
                                    .layoutPriority(1)
                                    .glassEffect(.clear)
                                    .font(.title)
                            }
                        }
                    }
                }
                .frame(width: 400, height: 85)
                //.background(.red)
            }
                //.scaledToFit()
            
                .frame(width: 420, height:100)
            //BOTTOM BAR RECENT NOTES
                .onAppear{
                    loadNotes()
                }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
