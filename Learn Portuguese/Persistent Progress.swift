//
//  Persistent Progress.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias TopicProgress = [String: ItemProgress]

let results: TopicProgress = [
    "Basic Greetings and Farewells" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Common Phrases" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Numbers (1-10)" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Colors" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Family Members" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Food and Drink" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Common Adjectives" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Days of the Week" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Weather Vocabulary" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false],
    "Common Verbs" : ["isQuizCompleted" : false, "isLessonRead": false, "isFlashcardsCompleted": false]
]
        //quizScore: 0



struct PersistentProgress {
    private static func defaultProgress() -> TopicProgress {
        var defaultProgress: TopicProgress = [:]
        
        for topic in LanguageViewModel().topics {
            defaultProgress[topic.title] = [
                "isQuizCompleted" : false,
                "isLessonRead" : false,
                "isFlashcardsCompleted" : false
            ]
        }
        
        return defaultProgress
    }
    
    private static func readProgresss() -> TopicProgress {
        UserDefaults.standard.dictionary(forKey: Key.progress) as? TopicProgress ?? TopicProgress()
    }
    
    var progress = PersistentProgress.readProgresss()
    {
        didSet {
            UserDefaults.standard.set(progress, forKey: Key.progress)
        }
    }
    
    private struct Key {
        static let progress = "Progress"
    }
}
