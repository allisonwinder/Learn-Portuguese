//
//  LanguageViewModel.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import Foundation

@Observable class LanguageViewModel {
    var topics: [Topic] = []
    var currentFlashcards: [VocabularyWord] = []
    var currentQuiz: [QuizQuestion] = []
    var currentQuestionIndex = 0
    var score = 0
    var timeBonus = 0

    // Load the topics data
    func loadTopics() {
        topics = [
            Topic(
                title: "Basic Greetings and Farewells",
                vocabulary: [
                    VocabularyWord(word: "Olá", translation: "Hello"),
                    VocabularyWord(word: "Adeus", translation: "Goodbye"),
                    // Add more words here
                ],
                lesson: "There are many basic greetings and farewells in Portuguese. Especially Brazilian speakers love to include a greeting at every chance they talk to you. Some vocabulary that you will be learning in this module is: Olá (Hello), Adeus (Goodbye), Bom dia (Good morning, Boa tarde (Good afternoon), Boa noite (Good night), Como você está? (How are you?), Estou bem (I am fine)and, Até logo (See you later)",
                isLessonRead: false,
                isFlashcardsCompleted: false,
                isQuizCompleted: false
            ),
            // Add more topics here
        ]
    }
    
    // Shuffle flashcards for a topic
    func shuffleFlashcards(for topic: Topic) {
        currentFlashcards = topic.vocabulary.shuffled()
    }
    
    // Handle quiz scoring and time bonus
    func handleQuizAnswer(isCorrect: Bool, elapsedTime: Int) {
        if isCorrect {
            score += 10
            let bonus = max(0, (20 - elapsedTime) / 2)
            timeBonus += bonus
            score += bonus
        }
        // Move to the next question or finish quiz
    }
}


