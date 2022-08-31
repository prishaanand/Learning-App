//
//  ContentView.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//
// Displays the list of lessons after a user selects a module

import SwiftUI

struct ContentView: View {
    
    //dont want to pass thru the module since hard once we traverse all the way down the view hierarchy
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ZStack {
            Image("learn-background2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea([.all])
            
            ScrollView {
                
                LazyVStack {
                    
                    //confirm that current module is set
                    if model.currentModule != nil {
                        
                        ForEach(0..<model.currentModule!.content.lessons.count) { index in
                            
                            NavigationLink {
                                ContentDetailView()
                                    .onAppear {
                                        model.beginLesson(index)
                                    }
                            } label: {
                                ContentViewRow(index: index)
                            }
                        }
                    }
                }
                .accentColor(.black)
                .padding()
                //title is empty string if no module is set
                .navigationBarTitle("Learn \(model.currentModule?.category ?? "")")
                
            }
            
        }
        
        
    }
}
