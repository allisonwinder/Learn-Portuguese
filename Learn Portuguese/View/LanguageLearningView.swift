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
                TopicCell(topic: topic)
            }
            .navigationTitle("Learn Portuguese!")
            .listStyle(.automatic)
        }
    }
}

struct TopicCell: View {
    let topic: Topic
    
    var body: some View {
        HStack {
            NavigationLink { TopicLessonView( topic: topic )
            } label: {
                Text(topic.title)
            }
        }
    }
}

struct TopicLessonView: View {
    let topic: Topic
    
    var body: some View {
        VStack(spacing: 20) {
                    Text("Learn this \(topic.title) lesson!")
                        .font(.title)
                    Text("\(topic.lesson)")
                        .padding()
            NavigationLink(destination: QuizView( topic: topic )) {
                        Text("Take the quiz")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
            NavigationLink(destination: FlashcardView( topic: topic )) {
                Text("Practice with flashcards")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
                }
                .padding()
    }
}

#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
