//
//  ContentView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI

struct LanguageLearningView: View {
    var languageViewModel = LanguageViewModel()
    
    var body: some View {
        NavigationStack {
            List(languageViewModel.topics) { topic in
                TopicCell(topic: topic, viewModel: languageViewModel)
            }
            .navigationTitle("Learn \(languageViewModel.languageName)!")
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
                TopicLessonView(topic: topic, result: viewModel.results(for: topic.title), viewModel: viewModel)
            } label: {
                VStack(alignment: .leading) {
                    Text(topic.title)
                        .font(.headline)
                        Text("Lesson read: \(viewModel.results(for: topic.title).isLessonRead)")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                    Text("Quiz Completed: \(viewModel.results(for: topic.title).isQuizCompleted)")
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    Text("Flashcards Completed: \(viewModel.results(for: topic.title).isFlashcardsCompleted)")
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    Text("Quiz High Score: \(String(format: "%.2f", viewModel.results(for: topic.title).quizScore ?? 0 ))")
                    .font(.subheadline)
                    .foregroundColor(.purple)
                }
            }
        }
    }
}


#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
