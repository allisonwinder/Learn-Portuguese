//
//  TopicLessonView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/18/24.
//

// Chat GPT wrote the UI for this page with minor adjustments by me. I wrote the buttons and the toggle.

import SwiftUI

struct TopicLessonView: View {
    let topic: Topic
    let result: Results
    let viewModel: LanguageViewModel
    
    var body: some View {
        ScrollView {
            VStack( spacing: TopicLessonConstants.paddingBetweenItems) {
                
                Text("Learn this \(topic.title) lesson!")
                    .font(.title)
                    .padding(.bottom)
                
                Text("\(topic.lesson)")
                    .font(.body)
                    .padding()
                    .background(.white)
                    .cornerRadius(Constants.cornerRadius)
                    .shadow(color: .black.opacity(Constants.opacity), radius: 5, x: 0, y: 4)
                    .lineSpacing(5)
                
                Toggle(isOn: Binding(
                    get: { viewModel.results(for: topic.title).isLessonRead },
                    set: { newValue in
                        viewModel.toggleLessonRead(for: topic.title)
                    }
                )) {
                    Text("Lesson read")
                        .font(.headline)
                }
                .padding()
                .background(.gray.opacity(Constants.opacity))
                .cornerRadius(Constants.cornerRadius)
                
                VStack(spacing: 15) {
                    NavigationLink(destination: QuizView(topic: topic)) {
                        Text("Take the quiz")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.cornerRadius)
                    }
                    
                    NavigationLink(destination: FlashcardView(viewModel: viewModel, topic: topic)) {
                        Text("Practice with flashcards")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(Constants.cornerRadius)
                    }
                }
                .padding(.top, TopicLessonConstants.paddingBetweenItems)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct TopicLessonConstants {
    static let paddingBetweenItems: CGFloat = 20
}

#Preview {
    TopicLessonView(topic: Topic(title: "Basic Greetings and Farewells",
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
                                      """), result: Results (
                                        topicTitle: "Basic Greetings and Farewells",
                                        quizScore: 0,
                                        isQuizCompleted: false,
                                        isLessonRead: false,
                                        isFlashcardsCompleted: false
                                      ), viewModel: LanguageViewModel())
}
