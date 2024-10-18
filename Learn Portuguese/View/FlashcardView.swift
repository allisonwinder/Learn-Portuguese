//
//  FlashcardView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import SwiftUI

struct FlashcardView: View {
    @State var viewModel: LanguageViewModel
    @State private var isFlipped = false
    @State private var currentIndex = 0 // To track the current word in the vocabulary list
    let topic: Topic
    
    var body: some View {
        ZStack {
            if isFlipped {
                Text(topic.vocabulary[currentIndex].word)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            } else {
                Text(topic.vocabulary[currentIndex].translation)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
        .onLongPressGesture {
            // Move to the next word when long-pressed
            currentIndex = (currentIndex + 1) % topic.vocabulary.count
            isFlipped = false // Reset to show the word side when moving to the next card
        }
    }
}

#Preview {
    let exampleTopic = Topic(
        title: "Basic Greetings and Farewells",
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
        isQuizCompleted: false
    )
    
    FlashcardView(viewModel: LanguageViewModel(), topic: exampleTopic )
}

