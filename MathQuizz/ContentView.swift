//
//  ContentView.swift
//  MathQuizz
//
//  Created by Mert Aydoğan on 13.05.2023.
//

import SwiftUI

struct Question {
    var text: String
    var answer: String
}

struct ContentView: View {
    
    /*@State private var questions = [
        Question(text: "2 + 2 =", answer: "4"),
        Question(text: "5 x 3 =", answer: "15"),
        Question(text: "10 - 7 =", answer: "3")
    ]*/
    
    @State private var currentQuestion: Question?
    @State private var score = 0
    @State private var userAnswer = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            
            Text(currentQuestion?.text ?? "")
                .font(.largeTitle)
                .padding()
            
            TextField("Enter your answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                checkAnswer()
            }, label: { Text("Reply")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .padding()
        }
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Game Over"),
                message: Text("Scores: \(score)"),
                dismissButton: .default(Text("Play again"), action: {
                    restartGame()
                })
            )
        })
    }
    /*
    func checkAnswer() {
        let userEnteredAnswer = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        let correctAnswer = questions[currentQuestion].answer
        
        if userEnteredAnswer == correctAnswer {
            score += 1
        } else {
            showAlert = true
        }
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
            userAnswer = ""
        } else {
            showAlert = true
        }
    }
     */
    func checkAnswer() {
            let userEnteredAnswer = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
            let correctAnswer = currentQuestion?.answer ?? ""
            
            if userEnteredAnswer == correctAnswer {
                score += 1
            } else {
                showAlert = true
            }
            
            generateQuestion()
            userAnswer = ""
        }
        
        func generateQuestion() {
            // Soru oluşturulurken buradaki mantığı değiştirebilirsiniz
            // Örnek olarak, rastgele iki sayı alıp toplama işlemi yapabilirsiniz
            let randomNumber1 = Int.random(in: 1...10)
            let randomNumber2 = Int.random(in: 1...10)
            let questionText = "\(randomNumber1) + \(randomNumber2) ="
            let correctAnswer = String(randomNumber1 + randomNumber2)
            
            currentQuestion = Question(text: questionText, answer: correctAnswer)
        }
        
    
    func restartGame() {
        currentQuestion = nil
        score = 0
        userAnswer = ""
        showAlert = false

        generateQuestion()
        //questions.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
