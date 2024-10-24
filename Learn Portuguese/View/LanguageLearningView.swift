//
//  ContentView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

struct LanguageLearningView: View {
    @State var languageViewModel = LanguageViewModel()
    
    var body: some View {
        NavigationStack {
            List(languageViewModel.topics) { topic in
                TopicCell(topic: topic, viewModel: languageViewModel)
            }
            .navigationTitle("Learn Portuguese!")
            .listStyle(.automatic)
        }
    }
}

struct TopicCell: View {
    let topic: Topic
    let viewModel: LanguageViewModel
    
    var body: some View {
        HStack {
            NavigationLink {
                // Passing the result dynamically to TopicLessonView
                TopicLessonView(topic: topic, result: getTopicResult(for: topic))
            } label: {
                Text(topic.title)
            }
        }
    }
    
    // Function to get the result for the specific topic dynamically
    private func getTopicResult(for topic: Topic) -> Results {
        // Search for the result matching the topic's title in the viewModel
        return viewModel.results.first(where: { $0.topicTitle == topic.title }) ?? Results(topicTitle: topic.title, quizScore: 0, isQuizCompleted: false, isLessonRead: false, isFlashcardsCompleted: false)
    }
}


#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
