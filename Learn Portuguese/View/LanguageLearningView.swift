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
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, LanguageLearningConstants.verticalPadding )
                    .padding(.horizontal)
            }
            .navigationTitle("Learn \(languageViewModel.languageName)!")
            .listStyle(.plain)
        }
    }
}


struct TopicCell: View {
    let topic: Topic
    let viewModel: LanguageViewModel
    
    var body: some View {
        
        NavigationLink {
            TopicLessonView(topic: topic, result: viewModel.results(for: topic.title), viewModel: viewModel)
        } label: {
            VStack(alignment: .leading, spacing: LanguageLearningConstants.progressRowHeight) {
                Text(topic.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: LanguageLearningConstants.progressRowHeight) {
                    
                    ProgressRow(
                        label: "Lesson read",
                        isComplete: LessonRead(topic.title),
                        icon: "book.fill")
                    
                    ProgressRow(
                        label: "Quiz Completed",
                        isComplete: QuizCompleted(topic.title),
                        icon: "checkmark.circle.fill")
                    
                    ProgressRow (
                        label: "Flashcards Completed",
                        isComplete: FlashcardsCompleted(topic.title),
                        icon: "document.fill")
                    
                    InfoRow (
                        label: "Quiz High Score",
                        value: String(format: "%.2f", HighScore(topic.title)),
                        icon: "star.fill")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius( Constants.cornerRadius )
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
    
    
    private func FlashcardsCompleted(_ topic: String ) -> Bool {
        return viewModel.results(for: topic).isFlashcardsCompleted
    }
    
    private func HighScore(_ topic: String ) -> Double {
        return viewModel.results(for: topic).quizScore ?? 0
    }
    
    private func LessonRead(_ topic: String ) -> Bool {
        return viewModel.results(for: topic).isLessonRead
    }
    
    private func QuizCompleted(_ topic: String ) -> Bool {
        return viewModel.results(for: topic).isQuizCompleted
    }
    

}

struct ProgressRow: View {
    let label: String
    let isComplete: Bool
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isComplete ? .green : .red)
            Text("\(label):")
                .font(.subheadline)
            Spacer()
            Text(isComplete ? "Yes" : "No")
                .font(.subheadline)
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.yellow)
            Text("\(label):")
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
    }
}

private struct LanguageLearningConstants {
    static let progressRowHeight: CGFloat = 8
    static let verticalPadding: CGFloat = 10
}



#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
