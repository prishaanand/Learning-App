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
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack (alignment: .leading) {
                //question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                //question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                //answers -- use rectangleCard
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            //move button outside zstack so that entire card is button
                            Button {
                                //track the selected index
                                selectedAnswerIndex = index
                                
                            } label: {
                                ZStack {
                                    
                                    if submitted == false {
                                        if index == selectedAnswerIndex {
                                            RectangleCard(color: Color.gray)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard(color: Color.white)
                                                .frame(height: 48)
                                        }
                                    }
                                    else {
                                        //answer has been submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            //correct answer
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex{
                                            //wrong answer
                                            RectangleCard(color: Color.red)
                                                .frame(height: 48)
                                            
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            //show the correct answer
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                            
                                        }
                                        else {
                                            RectangleCard(color: Color.white)
                                                .frame(height: 48)
                                        }
                                        
                                        
                                    }

                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                //submit button
                Button {
                    
                    //check if answer has been submitted
                    if submitted == true {
                        //move to next question
                        model.nextQuestion()
                        
                        //reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    else {
                        //submit the answer
                        
                        //prevent answer changing
                        submitted = true
                        
                        //check answer + inc counter if correct
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                }
                //havent selected an answer, so cant submit
                .disabled(selectedAnswerIndex == nil)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            //intial approach - test hasn't loaded yet
            //ProgressView()
            
            //final approach - show results view
            TestResultView(numCorrect: numCorrect)
        }
        
    }
    
    //computed property to determine whether to display submit, next, or finish
    var buttonText: String {
        //check if answer has been submitted
        
        guard model.currentModule != nil else {
            return ""
        }
        
        if submitted == true {
            
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                //last question
                return "Finish"
            }
            else {
                return "Next"
            }
        }
        else {
            return "Submit"
        }
        
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
