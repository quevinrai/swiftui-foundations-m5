//
//  TestView.swift
//  LearningApp
//
//  Created by Quevin Bambasi on 3/30/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        VStack {
            if model.currentQuestion != nil {
                VStack(alignment: .leading) {
                    // Question number
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                        .padding(.leading, 20)
                    
                    // Question
                    CodeTextView()
                        .padding(.horizontal, 20)
                    
                    // Answers
                    ScrollView {
                        VStack {
                            ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                                Button(action: {
                                    // Track the selected index
                                    selectedAnswerIndex = index
                                }, label: {
                                    ZStack {
                                        if submitted == false {
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48)
                                        } else {
                                            // Answer has been submitted
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                                // User has selected the right answer
                                                // Show a green background
                                                RectangleCard(color: .green)
                                                    .frame(height: 48)
                                            }
                                            else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                                // User has selected the wrong answer
                                                // Show a red background
                                                RectangleCard(color: .red)
                                                    .frame(height: 48)
                                            }
                                            else if index == model.currentQuestion!.correctIndex {
                                                // This button is the correct answer
                                                // Show a green background
                                                RectangleCard(color: .green)
                                                    .frame(height: 48)
                                            }
                                            else {
                                                RectangleCard(color: .white)
                                                    .frame(height: 48)
                                            }
                                        }
                                        
                                        Text(model.currentQuestion!.answers[index])
                                    }
                                })
                                .disabled(submitted)
                            }
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                    
                    // Submit Button
                    Button {
                        // Check if answer has been submitted
                        if submitted == true {
                            // Answer has already been submitted, move to the next question
                            model.nextQuestion()
                            
                            // Reset properties
                            submitted = false
                            selectedAnswerIndex = nil
                        }
                        
                        else {
                            // Submit the answer
                            
                            // Change submitted state to true
                            submitted = true
                            
                            // Check the answer and increment the counter if correct
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
                .navigationTitle("\(model.currentModule?.category ?? "") Test")
            }
            
            else {
                // If current question is nil, we show the result view
                TestResultView(numCorrect: numCorrect)
                
                // Test hasn't loaded yet
//                ProgressView()
            }
        }
    }
    
    var buttonText: String {
        // Check if answer has been submitted
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
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

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//            .environmentObject(ContentModel())
//    }
//}
