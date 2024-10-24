//
//  LanguageViewModel.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import Foundation

@Observable class LanguageViewModel {
    
    //MARK: - CONSTANTS
    
    //MARK: - Properties
    private var soundPlayer = SoundPlayer()
    
    private var lessonPlan: LessonPlan = PortugueseLessonPlan()
    
    //MARK: - Model Access
    
    var languageName: String {
        lessonPlan.languageName
    }
    
    var topics: [Topic] {
        lessonPlan.topics
    }
    
    func results (for title: String) -> Results {
        if let resultsRecord = lessonPlan.results.first(where: {$0.topicTitle == title}) {
            return resultsRecord
        }
        
        let resultsRecord = Results(topicTitle: title)
        
        lessonPlan.results.append(resultsRecord)
        
        return resultsRecord
    }
    
    
    
    //MARK: - User Intents
    
    
    
    func handleAnswer(isAnswerCorrect: Bool) {
        if isAnswerCorrect {
            Task {
                await soundPlayer.playSound(named: "correct-6033.mp3")
            }
        } else {
            Task {
                await soundPlayer.playSound(named: "wrong-47985.mp3")
            }
        }
    }
    
    func toggleLessonRead(for title: String) {
        lessonPlan.toggleLessonRead(for: title)
    }
    
    func toggleFlashcardsCompleted(for title: String) {
        lessonPlan.toggleFlashcardsCompleted(for: title)
    }
    
    func toggleQuizCompleted(for title: String) {
        lessonPlan.toggleQuizCompleted(for: title)
    }
    
    func quizHighScore(for title: String, score: Double) {
        lessonPlan.quizHighScore(for: title, score: score )
    }
    
//    init() {
//        self.results = [
//            Results(
//                topicTitle: "Basic Greetings and Farewells",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Common Phrases",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Numbers (1-10)",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Colors",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Family Members",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Food and Drink",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Common Adjectives",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Days of the Week",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Weather Vocabulary",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            ),
//            Results(
//                topicTitle: "Common Verbs",
//                quizScore: 0,
//                isQuizCompleted: false,
//                isLessonRead: false,
//                isFlashcardsCompleted: false
//            )
//        ]
 //   }
    
    
    
    
    
    
    //MARK: - Helpers
    
    //MARK: - Private Helpers

}


