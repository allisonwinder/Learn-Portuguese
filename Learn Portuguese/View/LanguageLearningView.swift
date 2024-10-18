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



#Preview {
    LanguageLearningView(languageViewModel: LanguageViewModel())
}
