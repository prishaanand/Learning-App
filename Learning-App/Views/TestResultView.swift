//
//  TestResultView.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/29/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var numCorrect:Int
    
    //computed property for the result text
    var resultHeading:String {
        
        //current module is still nill, return nothing
        guard model.currentModule != nil else {
            return ""
        }
        
        let percent = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if percent > 0.5 {
            return "Awesome!"
        }
        else if percent > 0.2 {
            return "Doing Great."
        }
        else{
            return "Keep Learning."
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            //dynamic text based on computed property
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions correct.")
            
            Spacer()
            Button {
                //send user to home view
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                        
                }
            
            }
            .padding()

            Spacer()
        }
        
    }
}
