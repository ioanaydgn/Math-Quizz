import SwiftUI

struct Question {
    let questionText: String
    let correctAnswer: Int
    let choices: [Int]
}

struct ContentView: View {
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var questions = [Question]()
    
    var body: some View {
        VStack {
            Text("Question \(currentQuestion + 1)/\(questions.count)")
                .font(.headline)
                .padding()
            
            Text("Score: \(score)")
                .font(.subheadline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            if currentQuestion < questions.count {
                Text(questions[currentQuestion].questionText)
                    .font(.title)
                    .padding()
                
                ForEach(0..<questions[currentQuestion].choices.count) { index in
                    Button(action: {
                        checkAnswer(index)
                    }) {
                        Text("\(questions[currentQuestion].choices[index])")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(showAlert)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Play Again"), action: {
                    resetGame()
                  }))
        }
        .onAppear {
            resetGame()
        }
    }
    
    func createRandomQuestion() -> Question {
        let num1 = Int.random(in: 1...99)
        let num2 = Int.random(in: 1...99)
        let operation = ["+", "-", "*"].randomElement()!
        let correctAnswer: Int
        var choices = [Int]()
        
        switch operation {
        case "+":
            correctAnswer = num1 + num2
        case "-":
            correctAnswer = num1 - num2
        case "*":
            correctAnswer = num1 * num2
        default:
            fatalError("Wrong operator!")
        }
        choices.append(correctAnswer)
        
        while choices.count < 4 {
            let randomAnswer = Int.random(in: correctAnswer - 5...correctAnswer + 5)
            if randomAnswer != correctAnswer && !choices.contains(randomAnswer) {
                choices.append(randomAnswer)
            }
        }
        choices.shuffle()
        
        let questionText = "\(num1) \(operation) \(num2) = ?"
        let question = Question(questionText: questionText, correctAnswer: correctAnswer, choices: choices)
        return question
    }
    
    func resetGame() {
        currentQuestion = 0
        score = 0
        showAlert = false
        alertMessage = ""
        questions.removeAll()
        for _ in 1...10 {
            questions.append(createRandomQuestion())
        }
    }

    func checkAnswer(_ selectedChoice: Int) {
        if questions[currentQuestion].correctAnswer == questions[currentQuestion].choices[selectedChoice] {
            score += 1
        } else {
            showAlert = true
            alertMessage = "Wrong answer! Your score is \(score)"
            return
        }
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            showAlert = true
            alertMessage = "Oyun bitti! Skorunuz: \(score)"
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
