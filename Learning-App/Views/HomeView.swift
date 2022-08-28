//
//  ContentView.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                Text("What would you like to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            
                            VStack (spacing: 20) {
                                //Learning Card
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: " \(module.content.lessons.count) Lessons", time: module.content.time)
                                
                                //Test Card -- duplicates lot of code so use a subview
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: " \(module.test.questions.count) Questions", time: module.test.time)
                            }
                            
                            
                        }
                    }
                    .padding(.all)
                }
            }
            
            .navigationTitle("Get Started")
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
