import SwiftUI

struct Question {
    var text: String
    var options: [String]
    var correctOptionIndex: Int
}

struct ContentView: View {
    @State private var currentQuestion: Question?
    @State private var score = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            
            Text(currentQuestion?.text ?? "")
                .font(.largeTitle)
                .padding()
                .padding()
            if let options = currentQuestion?.options {
                ForEach(0..<options.count) { index in
                    Button(action: {
                        checkAnswer(selectedOptionIndex: index)
                    }) {
                        Text(options[index])
                            .font(.title)
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    .padding(-1)
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text("Game Over"),
                message: Text("Your score: \(score)"),
                dismissButton: .default(Text("Play Again"), action: {
                    restartGame()
                })
            )
        })
        .onAppear {
            generateQuestion()
        }
    }
    
    func checkAnswer(selectedOptionIndex: Int) {
        guard let question = currentQuestion else { return }
        
        if selectedOptionIndex == question.correctOptionIndex {
            score += 1
        } else {
            showAlert = true
        }
        
        generateQuestion()
    }
    
    func generateQuestion() {
        
        let correctOptionIndex = Int.random(in: 0..<4)
        let correctAnswer = String(Int.random(in: 1...10))
        
        var options = [String]()
        for i in 0..<4 {
            if i == correctOptionIndex {
                options.append(correctAnswer)
            } else {
                // Yanlış cevapları rastgele seçebilirsiniz
                let wrongAnswer = String(Int.random(in: 1...10))
                options.append(wrongAnswer)
            }
        }
        
        let questionText = "Which number is correct?"
        
        currentQuestion = Question(text: questionText, options: options, correctOptionIndex: correctOptionIndex)
    }
    
    func restartGame() {
        currentQuestion = nil
        score = 0
        showAlert = false
        
        generateQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
