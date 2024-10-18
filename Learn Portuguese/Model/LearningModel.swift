//
//  LearningModel.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import Foundation

struct Topic: Identifiable {
    var id = UUID()
    var title: String
    var vocabulary: [VocabularyWord]
    var QuizQuestions: [QuizQuestion]
    var lesson: String
}

struct VocabularyWord: Identifiable {
    var id = UUID()
    var word: String
    var translation: String
}

struct QuizQuestion: Identifiable {
    var id = UUID()
    var question: String
    var options: [String]
    var correctAnswer: String
}

struct Results {
    var topicTitle: String
    var quizScore: Int
    var isQuizCompleted: Bool
    var quizTimeBonus: Int
    var isLessonRead: Bool
    var isFlashcardsCompleted: Bool
}

