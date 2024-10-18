//
//  Persistent Progress.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias TopicProgress = [String: ItemProgress]

struct PersistentProgress {
    var progress = UserDefaults.standard.dictionary(forKey: Key.progress) as? TopicProgress ?? TopicProgress()
    
 //   {
//        didSet {
//            UserDefaults.standard.set(soundIsEnabled, forKey: Key.soundEnabled)
//        }
 //   }
    
    private struct Key {
        static let progress = "Progress"
        static let highScores = "HighScores"
    }
}
