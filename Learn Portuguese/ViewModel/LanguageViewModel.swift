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

    
    
    //MARK: - Helpers
    
    //MARK: - Private Helpers

}


