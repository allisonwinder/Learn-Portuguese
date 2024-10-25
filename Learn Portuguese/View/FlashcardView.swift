//
//  FlashcardView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

// Chat GPT wrote the Card UI and some of the logic to get the card rotation correct. It also made the toggle not work when the quiz has not been completed. However, I made adjustments so it would work when it was completed.

import SwiftUI

struct FlashcardView: View {
    
    @State private var isFlipped = false
    @State private var currentIndex = 0
    @State var shuffledCards: [VocabularyWord] = []
    @State var contentRotation = 0.0

    let viewModel: LanguageViewModel
    let topic: Topic

    var body: some View {
        VStack {
            
            TabView(selection: $currentIndex) {
                
                ForEach(0..<shuffledCards.count, id: \.self) { index in
                    ZStack {
                        
                        VStack {
                            Text(isFlipped ? shuffledCards[index].word : shuffledCards[index].translation)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: FlashcardConstants.width, height: FlashcardConstants.height)
                        .background(LinearGradient(gradient: Gradient(colors: gradiantColors()), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(Constants.cornerRadius + 8.0)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                        .rotation3DEffect(
                            .degrees(isFlipped ? FlashcardConstants.flipped : FlashcardConstants.notFlipped),
                            axis: (x: 0, y: 1, z: 0)
                        )
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onTapGesture {
                withAnimation(Animation.linear(duration: Constants.animationDuration)) {
                    contentRotation = isFlipped ? FlashcardConstants.notFlipped : FlashcardConstants.flipped
                    isFlipped.toggle()
                }
            }
            .onAppear {
                shuffledCards = topic.vocabulary.shuffled()
            }
            .onChange(of: currentIndex) {
                withAnimation {
                    isFlipped = false
                    contentRotation = isFlipped ? FlashcardConstants.flipped : FlashcardConstants.notFlipped
                }
            }

            VStack {
                Toggle(isOn: Binding(
                    get: { viewModel.results(for: topic.title).isFlashcardsCompleted },
                    set: { newValue in
                        viewModel.toggleFlashcardsCompleted(for: topic.title)
                    }
                )) {
                    Text("Flashcards Completed")
                        .font(.headline)
                        .padding(.vertical, 8)
                }
                .padding()
                .background(.gray.opacity(Constants.opacity))
                .cornerRadius(Constants.cornerRadius)
                .shadow(radius: 4)
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 30)
        }
    }
    
    private func gradiantColors() -> [Color] {
        return isFlipped ? [.blue, .purple] : [.green, .teal]
    }
    
    private struct FlashcardConstants {
        static let flipped = 180.0
        static let notFlipped = 0.0
        static let width: CGFloat = 300
        static let height: CGFloat = 200
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
