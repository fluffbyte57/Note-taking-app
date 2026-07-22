//
//  ContentView.swift
//  Note taking app
//
//  Created by Yacov Vladimirovich on 7/21/26.
//  ooooo cool project awesome sauce


// Nevermind now i know how to commit, i'm a genius

import SwiftUI

struct ContentView: View {

    @AppStorage("currentnote") private var currentnote = ""
    @State private var notes: [String]  = [
        "First note",
        "Second note",
        "DEv note"
    ]
    
    //.preferredColorScheme(darkMode? .dark : .light)
    @State private var darkMode = false
    
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
                            print("Deleted the current note")
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
                            //print(darkMode)
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
                            //print("Placeholder")
                            print(notes)
                            currentnote = notes[0]
                        } label: {
                            Image(systemName: "a")
                                .glassEffect()
                                .font(.system(size: 40))
                        }
                        Button{
                            //print("Cleared current text AND created a new note")
                            print(currentnote, " is the current saved note")
                            notes.append(currentnote)
                            print(notes , " are all the notes saved")
                            //print(notes)
                            currentnote = ""
                            //temporarily just "clear" the current notes so that the user can write new notes
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
        
        VStack{
            TextEditor(text: $currentnote)
                .scrollContentBackground(.hidden)
                .background(.ultraThinMaterial)
                .frame(height: 550)
                .font(.system(size: 30))
                //.glassEffect(.regular)
                //.background(.gray)
                //.fill(.ultraThinMaterial)
                //.glassEffect(.clear)
                .cornerRadius(30)
                .padding()
            Spacer()
            //TEXT BOX
        }
        
        VStack{
            Text("Recents")
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(.ultraThinMaterial)
                VStack(spacing: 5){
                    Button{
                        currentnote = notes[0]
                        //testButton to load in eg note[1] or whichever chosen IN CODE not current interchangeable...
                    } label: {
                        Text(notes[0])
                    }
                    Button{
                        currentnote = notes[1] 
                        //testButton to load in eg note[1] or whichever chosen IN CODE not current interchangeable...
                    } label: {
                        Text(notes[1])
                    }
                }
                //Button(notes[2])
            }
            //Image(.placeholder)
            //    .resizable()
                //.scaledToFit()
            
                .frame(width: 350, height:100)
            //BOTTOM BAR RECENT NOTES
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }

}

#Preview {
    ContentView()
}
