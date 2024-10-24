//
//  FlashcardView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import SwiftUI

struct FlashcardView: View {
    @State var viewModel: LanguageViewModel
    @State private var isFlipped = false
    @State private var currentIndex = 0 // To track the current word in the vocabulary list
    @State var shuffledCards: [VocabularyWord] = []
    @State var contentRotation = 0.0
    let topic: Topic
    //var result: Results

    var body: some View {
        
        TabView(selection: $currentIndex) {
            ForEach(0..<shuffledCards.count, id: \.self) { index in
                ZStack {
                    // Background gradient
                    let gradientColors = isFlipped ? [Color.blue, Color.purple] : [Color.green, Color.teal]
                    
                    VStack {
                        Text(isFlipped ? shuffledCards[index].word : shuffledCards[index].translation)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 300, height: 200) // Adjust the frame size for a compact look
                    .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                    .rotation3DEffect(
                        .degrees(isFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.5)) {
                contentRotation = isFlipped ? 0.0 : 180.0
                isFlipped.toggle()
            }
        }
        .onAppear {
            // Optionally shuffle cards on appear if desired
            shuffledCards = topic.vocabulary.shuffled()
        }
        .onChange(of: currentIndex) {
            // Reset the flip state when the user swipes to a new card
            withAnimation {
                isFlipped = false
                contentRotation = isFlipped ? 180.0 : 0
            }
        }
        Button {
            viewModel.toggleFlashcardsCompleted(for: topic.title)
        }
        label : {
            Text("Flashcards Completed: \(viewModel.results(for: topic.title).isFlashcardsCompleted)")
                .font(.subheadline)
        }
    }
}

#Preview {
    let exampleTopic = Topic(
        title: "Basic Greetings and Farewells",
        vocabulary: [
            VocabularyWord(word: "Olá", translation: "Hello"),
            VocabularyWord(word: "Adeus", translation: "Goodbye"),
            VocabularyWord(word: "Bom dia", translation: "Good morning"),
            VocabularyWord(word: "Boa tarde", translation: "Good afternoon"),
            VocabularyWord(word: "Boa noite", translation: "Good night"),
            VocabularyWord(word: "Como você está?", translation: "How are you?"),
            VocabularyWord(word: "Estou bem", translation: "I am fine"),
            VocabularyWord(word: "Até logo", translation: "See you later")
        ],
        QuizQuestions: [
            QuizQuestion(question: "What is the Portuguese word for 'hello'?", options: ["Adeus", "Olá", "Bom dia", "Boa tarde"], correctAnswer: "Olá"),
            QuizQuestion(question: "What does 'Adeus' mean in English?", options: ["Hello", "Goodbye", "Good night", "See you later"], correctAnswer: "Goodbye"),
            QuizQuestion(question: "What is the Portuguese term for 'good morning'?", options: ["Boa noite", "Olá", "Bom dia", "Boa tarde"], correctAnswer: "Bom dia"),
            QuizQuestion(question: "What is the translation of 'Boa tarde'?", options: ["Good morning", "Good afternoon", "Good night", "Hello"], correctAnswer: "Good afternoon"),
            QuizQuestion(question: "Which word means 'good night' in Portuguese?", options: ["Boa tarde", "Boa noite", "Adeus", "Olá"], correctAnswer: "Boa noite"),
            QuizQuestion(question: "What does 'Estou bem' mean in English?", options: ["How are you?", "See you later", "I am fine", "Good night"], correctAnswer: "I am fine"),
            QuizQuestion(question: "What is the Portuguese word for 'How are you'?", options: ["Boa tarde", "Como você está?", "Adeus", "Até logo"], correctAnswer: "Como você está?"),
            QuizQuestion(question: "What does 'Até logo' mean?", options: ["Goodbye", "See you later", "Good morning", "Hello"], correctAnswer: "See you later"),
            QuizQuestion(question: "Which phrase means 'goodbye'?", options: ["Até logo", "Boa tarde", "Adeus", "Olá"], correctAnswer: "Adeus"),
            QuizQuestion(question: "What is the Portuguese word for 'see you later'?", options: ["Olá", "Boa noite", "Adeus", "Até logo"], correctAnswer: "Até logo")
        ],
        lesson: """
        There are many basic greetings and farewells in Portuguese. Especially Brazilian speakers love to include a greeting at every chance they talk to you. Some vocabulary that you will be learning in this module includes: Olá (Hello), Adeus (Goodbye), Bom dia (Good morning), Boa tarde (Good afternoon), Boa noite (Good night), Como você está? (How are you?), Estou bem (I am fine), and Até logo (See you later).
        """
    )
    
    FlashcardView(viewModel: LanguageViewModel(), topic: exampleTopic )
}
