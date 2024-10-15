//
//  FlashcardView.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import SwiftUI

struct FlashcardView: View {
    
    @State private var isFlipped = false
    var word: VocabularyWord
    
    var body: some View {
        ZStack {
            if isFlipped {
                Text(word.translation)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            } else {
                Text(word.word)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        //.frame(width: 300, height: 200)
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}


#Preview {
    FlashcardView(word: VocabularyWord(word: "Olá", translation: "Hello"))
}
