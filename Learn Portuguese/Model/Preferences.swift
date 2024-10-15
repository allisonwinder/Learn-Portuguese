//
//  Preferences.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import Foundation

class Preferences {
    static func saveProgress(for topic: Topic) {
        UserDefaults.standard.set(topic.isLessonRead, forKey: "\(topic.title)_lesson")
        // Add other states as needed
    }

    static func loadProgress(for topic: Topic) -> Topic {
        var modifiedTopic = topic
        modifiedTopic.isLessonRead = UserDefaults.standard.bool(forKey: "\(topic.title)_lesson")
        // Load other states as needed
        return modifiedTopic
    }
}

