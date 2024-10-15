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
    var lesson: String
    var isLessonRead: Bool
    var isFlashcardsCompleted: Bool
    var isQuizCompleted: Bool
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
    var timeBonus: Int
}

struct QuizResult {
    var score: Int
    var isCompleted: Bool
}

