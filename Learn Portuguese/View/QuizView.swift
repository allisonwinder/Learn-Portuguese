//
//  QuizView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//
import SwiftUI

struct QuizView: View {
    @State var topic: Topic
    @State private var currentQuestionIndex = 0
    @State private var score = 0.0
    @State private var isAnswerCorrect = false
    @State private var showScore = false
    @State private var selectedOption: String? = nil
    @State private var remainingTime = 10.0
    @State private var timer: Timer? = nil
    @State private var animatedBonusRemaining = 0.0
    @State private var isCorrectAnimation = false
    @State private var isWrongAnimation = false
    @State private var questionsCorrect = 0
    
    let viewModel = LanguageViewModel()
    
    var body: some View {
        VStack {
            // Show the current question
            Text("Question \(currentQuestionIndex + 1) of \(topic.QuizQuestions.count)")
                .font(.headline)
                .padding()

            Text(topic.QuizQuestions[currentQuestionIndex].question)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            // Show the options as buttons
            ForEach(topic.QuizQuestions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    isAnswerCorrect = (option == topic.QuizQuestions[currentQuestionIndex].correctAnswer)
                    handleAnswer()
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? (isAnswerCorrect ? Color.green : Color.red) : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .scaleEffect(isAnswerCorrect && selectedOption == option ? isCorrectAnimation ? 1.15 : 1 : isWrongAnimation && selectedOption == option ? 0.8 : 1)
                        .animation(.spring(), value: isCorrectAnimation || isWrongAnimation)
                }
            }

            // Display the current score
            Text("Score: \(String(format: "%.2f", score))")
                .font(.title)
                .padding()

            // Animated pie for bonus time
            Pie(
                startAngle: angle(for: 0),
                endAngle: angle(for: -animatedBonusRemaining)
            )
            .onAppear {
                startTimer()
            }
            .foregroundStyle(.orange)
            .opacity(0.4)
            .padding()

            Spacer()

            // Button to go to next question or finish quiz
            Button(action: {
                nextQuestion()
            }) {
                Text(currentQuestionIndex < topic.QuizQuestions.count - 1 ? "Next Question" : "Finish Quiz")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showScore) {
            Alert(
                title: Text("Quiz Completed"),
                message: Text("Your score: \(String(format: "%.2f", score))"),
                dismissButton: .default(Text("OK"))
            )
        }
        Button {
            viewModel.toggleQuizCompleted(for: topic.title)
        } label: {
            Text("Quiz Completed: \(viewModel.results(for: topic.title).isQuizCompleted)")
        }
        .font(.subheadline)
        .foregroundColor(.purple)
    }


    // Function to calculate the angle for the pie
    private func angle(for percentOfCircle: Double) -> Angle {
        Angle.degrees(percentOfCircle * 360 - 90)
    }

    // Function to handle the answer selection
    private func handleAnswer() {
        viewModel.handleAnswer(isAnswerCorrect: isAnswerCorrect)
        if isAnswerCorrect {
            let bonus = remainingTime // Bonus based on remaining time
            score += 10.0 + bonus
            stopTimer() // Stop the timer when the correct answer is given
            triggerCorrectAnimation()
            questionsCorrect += 1
        } else {
            triggerWrongAnimation()
        }
    }

    // Function to move to the next question or finish the quiz
    private func nextQuestion() {
        if currentQuestionIndex < topic.QuizQuestions.count - 1 {
            currentQuestionIndex += 1
            resetState()
        } else {
            showScore = true
            if questionsCorrect == topic.QuizQuestions.count {
                viewModel.toggleQuizCompleted(for: topic.title)
            }
            viewModel.quizHighScore(for: topic.title, score: Double(score))
        }
    }

    // Reset the state for the next question
    private func resetState() {
        selectedOption = nil
        isAnswerCorrect = false
        remainingTime = 10.0
        animatedBonusRemaining = 1.0
        startTimer()
        isCorrectAnimation = false
        isWrongAnimation = false
    }

    // Function to start the timer
    private func startTimer() {
        animatedBonusRemaining = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 0.1
                animatedBonusRemaining = remainingTime / 10.0
            } else {
                stopTimer() 
            }
        }
    }

    // Function to stop the timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Trigger correct answer animation
    private func triggerCorrectAnimation() {
        withAnimation(.easeIn(duration: 0.5)) {
            isCorrectAnimation = true
        }
    }

    // Trigger wrong answer animation
    private func triggerWrongAnimation() {
        withAnimation(.easeOut(duration: 0.3)) {
            isWrongAnimation = true
        }
    }
}


#Preview {
    QuizView(topic: Topic(            title: "Basic Greetings and Farewells",
                                      vocabulary: [
                                          VocabularyWord(word: "Olá", translation: "Hello"),
                                          VocabularyWord(word: "Adeus", translation: "Goodbye"),
                                          VocabularyWord(word: "Bom dia", translation: "Good morning"),
                                          VocabularyWord(word: "Boa tarde", translation: "Good afternoon"),
                                          VocabularyWord(word: "Boa noite", translation: "Good night"),
                                          VocabularyWord(word: "Como você está?", translation: "How are you?"),
                                          VocabularyWord(word: "Estou bem", translation: "I am fine"),
                                          VocabularyWord(word: "Até logo", translation: "See you later")
                                      ],
                                      QuizQuestions: [
                                          QuizQuestion(question: "What is the Portuguese word for 'hello'?", options: ["Adeus", "Olá", "Bom dia", "Boa tarde"], correctAnswer: "Olá"),
                                          QuizQuestion(question: "What does 'Adeus' mean in English?", options: ["Hello", "Goodbye", "Good night", "See you later"], correctAnswer: "Goodbye"),
                                          QuizQuestion(question: "What is the Portuguese term for 'good morning'?", options: ["Boa noite", "Olá", "Bom dia", "Boa tarde"], correctAnswer: "Bom dia"),
                                          QuizQuestion(question: "What is the translation of 'Boa tarde'?", options: ["Good morning", "Good afternoon", "Good night", "Hello"], correctAnswer: "Good afternoon"),
                                          QuizQuestion(question: "Which word means 'good night' in Portuguese?", options: ["Boa tarde", "Boa noite", "Adeus", "Olá"], correctAnswer: "Boa noite"),
                                          QuizQuestion(question: "What does 'Estou bem' mean in English?", options: ["How are you?", "See you later", "I am fine", "Good night"], correctAnswer: "I am fine"),
                                          QuizQuestion(question: "What is the Portuguese word for 'How are you'?", options: ["Boa tarde", "Como você está?", "Adeus", "Até logo"], correctAnswer: "Como você está?"),
                                          QuizQuestion(question: "What does 'Até logo' mean?", options: ["Goodbye", "See you later", "Good morning", "Hello"], correctAnswer: "See you later"),
                                          QuizQuestion(question: "Which phrase means 'goodbye'?", options: ["Até logo", "Boa tarde", "Adeus", "Olá"], correctAnswer: "Adeus"),
                                          QuizQuestion(question: "What is the Portuguese word for 'see you later'?", options: ["Olá", "Boa noite", "Adeus", "Até logo"], correctAnswer: "Até logo")
                                      ],
                                      lesson: """
                                      There are many basic greetings and farewells in Portuguese. Especially Brazilian speakers love to include a greeting at every chance they talk to you. Some vocabulary that you will be learning in this module includes: Olá (Hello), Adeus (Goodbye), Bom dia (Good morning), Boa tarde (Good afternoon), Boa noite (Good night), Como você está? (How are you?), Estou bem (I am fine), and Até logo (See you later).
                                      """))
}

