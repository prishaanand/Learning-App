//
//  TestView.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/29/22.
//

import SwiftUI

struct TestView: View {
    
    //know what quiz to display
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
                //question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                //question
                CodeTextView()
                
                //answers
                
                
                //button
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            //test hasn't loaded yet
            ProgressView()
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
