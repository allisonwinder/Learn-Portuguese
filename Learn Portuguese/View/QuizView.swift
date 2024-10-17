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
    @State private var score = 0
    @State private var isAnswerCorrect = false
    @State private var showScore = false
    @State private var selectedOption: String? = nil
    @State private var timeBonus = 20
    
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
                }
            }

            // Display the current score
            Text("Score: \(score)")
                .font(.title)
                .padding()

            // Bonus time countdown animation
            ProgressView(value: Double(timeBonus), total: 20.0)
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    startBonusCountdown()
                }

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
                message: Text("Your score: \(score)"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // Function to handle the answer selection
    private func handleAnswer() {
        if isAnswerCorrect {
            score += 1
        }
    }

    // Function to move to the next question or finish the quiz
    private func nextQuestion() {
        if currentQuestionIndex < topic.QuizQuestions.count - 1 {
            currentQuestionIndex += 1
            resetState()
        } else {
            showScore = true
            topic.isQuizCompleted = true // Mark quiz as completed in the topic
        }
    }

    // Reset the state for the next question
    private func resetState() {
        selectedOption = nil
        isAnswerCorrect = false
        timeBonus = 20
    }

    // Function to start bonus countdown
    private func startBonusCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeBonus > 0 {
                timeBonus -= 1
            } else {
                timer.invalidate()
            }
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
                                      """,
                                      isLessonRead: false,
                                      isFlashcardsCompleted: false,
                                      isQuizCompleted: false))
}

