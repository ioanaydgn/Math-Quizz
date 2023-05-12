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
    let questions = [
        Question(text: "2 + 2 =", answer: "4"),
        Question(text: "5 x 3 =", answer: "15"),
        Question(text: "10 - 7 =", answer: "3")
    ]
    
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var userAnswer = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text(questions[currentQuestion].text)
                .font(.largeTitle)
                .padding()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
