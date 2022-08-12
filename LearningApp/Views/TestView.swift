//
//  TestView.swift
//  LearningApp
//
//  Created by Andy on 7/26/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
        
            VStack (alignment: .leading) {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    
                    VStack {
                        
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            
                            
                            Button {
                                // Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                
                                ZStack {
                                    
                                    if !submitted {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    } else {
                                        // Answer had been submitted
                                        if (index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex) || (index == model.currentQuestion!.correctIndex) {
                                            
                                            // show green background
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                            
                                        } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            
                                            // selected but not the right answer, show red background
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                            
                                        } else {
                                            RectangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                        
                                    }
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                                
                            }
                            .disabled(submitted)
                            
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
                
                // Submit Button
                Button {
                    
                    // check if answer has been submitted
                    if submitted {
                        
                        // Answer has already been submitted, move to next question
                        model.nextQuestion()
                        
                        // Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                        
                    } else {
                        
                        // tap for submit answer
                        // chage submitted state to true
                        submitted = true
                        
                        // Check answer and increment counter if correct
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
                .disabled(selectedAnswerIndex == nil)

                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        } else {
            ProgressView()
        }
        
    }
    
    var buttonText:String {
        
        // check if answer has been submitted
        if submitted {
            
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish"
            } else {
                return "Next"
            }
            
        } else {
            return "Submit"
        }
        
    }
}
