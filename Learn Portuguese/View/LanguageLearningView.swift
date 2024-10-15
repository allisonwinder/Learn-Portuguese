//
//  ContentView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/10/24.
//

import SwiftUI


let topics = [
    "Basic Greetings and Farewells",
    "Common Phrases",
    "Numbers (1-10)",
    "Colors",
    "Family Members",
    "Food and Drink",
    "Common Adjectives",
    "Days of the Week",
    "Weather Vocabulary",
    "Common Verbs"
]

struct LanguageLearningView: View {
    @State var languageViewModel = LanguageViewModel()
    
    var body: some View {
        NavigationStack {
            List(languageViewModel.topics, id: \.self) { topic in
                TopicCell(topic: String(topic))
            }
            .navigationTitle("Learn Portuguese!")
            .listStyle(.plain)
        }
    }
}

struct TopicCell: View {
    let topic: String
    
    var body: some View {
        HStack {
            NavigationLink { TopicLessonView(topic: topic)
            } label: {
                Text(topic)
            }
        }
    }
}

struct TopicLessonView: View {
    let topic: String
    
    var body: some View {
        VStack {
            Text("Learn this \(topic) lesson!")
            NavigationLink {
                QuizScreen()
            } label: {
                Text("Take the quiz")
            }
        }
    }
}
    
struct QuizScreen: View {
    var body: some View {
        VStack {
            Form {
                Section {
                    Text("Question N Goes here")
                }
                Section {
                    Text("a. Answer a")
                    Text("a. Answer a")
                    
                }
            }
        }
    }
}

struct QuizView: View {
    @State var viewModel: LanguageViewModel
    @State private var elapsedTime = 0
    @State private var isCorrect = false
    
    var body: some View {
        VStack {
            Text(viewModel.currentQuiz[viewModel.currentQuestionIndex].question)
                .font(.title)
            
            ForEach(viewModel.currentQuiz[viewModel.currentQuestionIndex].options, id: \.self) { option in
                Button(option) {
                    isCorrect = (option == viewModel.currentQuiz[viewModel.currentQuestionIndex].correctAnswer)
                    viewModel.handleQuizAnswer(isCorrect: isCorrect, elapsedTime: elapsedTime)
                }
                .padding()
                .background(isCorrect ? Color.green : Color.red)
                .cornerRadius(10)
            }

            // Bonus time countdown animation
            ProgressView(value: Double(elapsedTime), total: 20.0)
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if elapsedTime < 20 {
                            elapsedTime += 1
                        } else {
                            timer.invalidate()
                        }
                    }
                }

            // Display score
            Text("Score: \(viewModel.score)")
        }
    }
}


#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
