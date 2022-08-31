//
//  ContentViewRow.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    
    //computed property to fix bug - check for index being out of range
    
     var lesson: Lesson {
         if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
             return model.currentModule!.content.lessons[index]
         }
         else {
             return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
         }
     }
     
    
    var body: some View {
        
        //display lesson card
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack (spacing: 30) {
                
                Text(String(index + 1))
                    .bold()
                VStack (alignment: .leading) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
                
                
            }
            .padding()
            
        }
        .padding(.bottom, 5)
        
        
    }
}
