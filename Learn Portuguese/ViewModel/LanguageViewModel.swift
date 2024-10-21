//
//  LanguageViewModel.swift
//  Learn Portuguese
//
//  Created by IS 543 on 10/15/24.
//

import Foundation

@Observable class LanguageViewModel {
    
    //MARK: - CONSTANTS
    
    //MARK: - Properties
    private var currentFlashcards: [VocabularyWord] = []
    private var soundPlayer = SoundPlayer()
    var currentQuiz: [QuizQuestion] = []
    var currentQuestionIndex = 0
    private var score = 0
    private var timeBonus = 0
    
    //MARK: - Model Access
    
    //MARK: - User Intents
    func handleAnswer(isAnswerCorrect: Bool) {
        if isAnswerCorrect {
            Task {
                await soundPlayer.playSound(named: "correct-6033.mp3")
            }
        } else {
            Task {
                await soundPlayer.playSound(named: "wrong-47985.mp3")
            }
        }
    }
    
    let topics: [Topic] = [
        Topic(
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
        ),
        
        Topic(
            title: "Common Phrases",
            vocabulary: [
                VocabularyWord(word: "Por favor", translation: "Please"),
                VocabularyWord(word: "Obrigado/Obrigada", translation: "Thank you"),
                VocabularyWord(word: "De nada", translation: "You're welcome"),
                VocabularyWord(word: "Desculpe", translation: "I'm sorry"),
                VocabularyWord(word: "Quanto custa?", translation: "How much does it cost?"),
                VocabularyWord(word: "Onde está...?", translation: "Where is...?"),
                VocabularyWord(word: "Eu gostaria...", translation: "I would like...")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'please'?", options: ["Obrigado", "Desculpe", "Por favor", "De nada"], correctAnswer: "Por favor"),
                QuizQuestion(question: "What does 'Obrigado/Obrigada' mean in English?", options: ["You're welcome", "I'm sorry", "Thank you", "Please"], correctAnswer: "Thank you"),
                QuizQuestion(question: "What is the Portuguese term for 'You're welcome'?", options: ["Obrigado", "Desculpe", "De nada", "Por favor"], correctAnswer: "De nada"),
                QuizQuestion(question: "What is the translation of 'Desculpe'?", options: ["I'm sorry", "Thank you", "Please", "You're welcome"], correctAnswer: "I'm sorry"),
                QuizQuestion(question: "Which phrase means 'How much does it cost?' in Portuguese?", options: ["Onde está...?", "Quanto custa?", "Eu gostaria", "De nada"], correctAnswer: "Quanto custa?"),
                QuizQuestion(question: "What does 'Onde está...?' mean in English?", options: ["Where is...?", "How much does it cost?", "I would like", "Please"], correctAnswer: "Where is...?"),
                QuizQuestion(question: "What is the Portuguese phrase for 'I would like'?", options: ["Quanto custa", "Eu gostaria", "Por favor", "De nada"], correctAnswer: "Eu gostaria"),
                QuizQuestion(question: "What does 'Por favor' mean?", options: ["Please", "I'm sorry", "Thank you", "Where is...?"], correctAnswer: "Please"),
                QuizQuestion(question: "Which phrase means 'I'm sorry'?", options: ["Obrigado", "Desculpe", "Por favor", "De nada"], correctAnswer: "Desculpe"),
                QuizQuestion(question: "What is the Portuguese phrase for 'thank you'?", options: ["Por favor", "De nada", "Obrigado/Obrigada", "Quanto custa?"], correctAnswer: "Obrigado/Obrigada")
            ],
            lesson: """
            Common phrases in Portuguese include essential words for daily communication. Some of the vocabulary you will learn includes: Por favor (Please), Obrigado/Obrigada (Thank you), De nada (You're welcome), Desculpe (I'm sorry), Quanto custa? (How much does it cost?), Onde está...? (Where is...?), and Eu gostaria (I would like).
            """
        ),

        Topic(
            title: "Numbers (1-10)",
            vocabulary: [
                VocabularyWord(word: "Um", translation: "1"),
                VocabularyWord(word: "Dois", translation: "2"),
                VocabularyWord(word: "Três", translation: "3"),
                VocabularyWord(word: "Quatro", translation: "4"),
                VocabularyWord(word: "Cinco", translation: "5"),
                VocabularyWord(word: "Seis", translation: "6"),
                VocabularyWord(word: "Sete", translation: "7"),
                VocabularyWord(word: "Oito", translation: "8"),
                VocabularyWord(word: "Nove", translation: "9"),
                VocabularyWord(word: "Dez", translation: "10")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'one'?", options: ["Dois", "Um", "Três", "Dez"], correctAnswer: "Um"),
                QuizQuestion(question: "What does 'Cinco' mean in English?", options: ["3", "4", "5", "6"], correctAnswer: "5"),
                QuizQuestion(question: "What is the Portuguese word for 'ten'?", options: ["Sete", "Dez", "Oito", "Quatro"], correctAnswer: "Dez"),
                QuizQuestion(question: "What is the translation of 'Sete'?", options: ["6", "7", "8", "9"], correctAnswer: "7"),
                QuizQuestion(question: "Which word means 'four' in Portuguese?", options: ["Três", "Oito", "Quatro", "Nove"], correctAnswer: "Quatro"),
                QuizQuestion(question: "What does 'Dois' mean in English?", options: ["1", "2", "3", "5"], correctAnswer: "2"),
                QuizQuestion(question: "What is the Portuguese word for 'eight'?", options: ["Sete", "Oito", "Seis", "Nove"], correctAnswer: "Oito"),
                QuizQuestion(question: "What does 'Nove' mean in English?", options: ["7", "8", "9", "10"], correctAnswer: "9"),
                QuizQuestion(question: "Which word means 'three' in Portuguese?", options: ["Dois", "Três", "Seis", "Dez"], correctAnswer: "Três"),
                QuizQuestion(question: "What is the Portuguese word for 'six'?", options: ["Cinco", "Seis", "Sete", "Nove"], correctAnswer: "Seis")
            ],
            lesson: """
            Learning numbers is crucial when speaking Portuguese. In this module, you will cover the basics, including numbers from 1 to 10: Um (1), Dois (2), Três (3), Quatro (4), Cinco (5), Seis (6), Sete (7), Oito (8), Nove (9), and Dez (10).
            """
        ),
        Topic(
            title: "Colors",
            vocabulary: [
                VocabularyWord(word: "Vermelho", translation: "Red"),
                VocabularyWord(word: "Azul", translation: "Blue"),
                VocabularyWord(word: "Amarelo", translation: "Yellow"),
                VocabularyWord(word: "Verde", translation: "Green"),
                VocabularyWord(word: "Preto", translation: "Black"),
                VocabularyWord(word: "Branco", translation: "White"),
                VocabularyWord(word: "Roxo", translation: "Purple"),
                VocabularyWord(word: "Laranja", translation: "Orange")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'red'?", options: ["Azul", "Vermelho", "Verde", "Preto"], correctAnswer: "Vermelho"),
                QuizQuestion(question: "What does 'Azul' mean in English?", options: ["Red", "Blue", "Yellow", "Purple"], correctAnswer: "Blue"),
                QuizQuestion(question: "What is the Portuguese word for 'yellow'?", options: ["Amarelo", "Vermelho", "Verde", "Branco"], correctAnswer: "Amarelo"),
                QuizQuestion(question: "What is the translation of 'Verde'?", options: ["Green", "Red", "Yellow", "White"], correctAnswer: "Green"),
                QuizQuestion(question: "Which color means 'black' in Portuguese?", options: ["Branco", "Preto", "Azul", "Roxo"], correctAnswer: "Preto"),
                QuizQuestion(question: "What does 'Branco' mean in English?", options: ["White", "Black", "Orange", "Green"], correctAnswer: "White"),
                QuizQuestion(question: "What is the Portuguese word for 'purple'?", options: ["Roxo", "Laranja", "Preto", "Verde"], correctAnswer: "Roxo"),
                QuizQuestion(question: "Which color means 'orange'?", options: ["Laranja", "Azul", "Amarelo", "Roxo"], correctAnswer: "Laranja"),
                QuizQuestion(question: "What is the Portuguese word for 'white'?", options: ["Preto", "Amarelo", "Branco", "Roxo"], correctAnswer: "Branco"),
                QuizQuestion(question: "What does 'Preto' mean in English?", options: ["Black", "Blue", "Purple", "White"], correctAnswer: "Black")
            ],
            lesson: """
            Colors are an essential part of any language. In Portuguese, you will learn the following colors: Vermelho (Red), Azul (Blue), Amarelo (Yellow), Verde (Green), Preto (Black), Branco (White), Roxo (Purple), and Laranja (Orange).
            """
        ),

        Topic(
            title: "Family Members",
            vocabulary: [
                VocabularyWord(word: "Pai", translation: "Father"),
                VocabularyWord(word: "Mãe", translation: "Mother"),
                VocabularyWord(word: "Irmão", translation: "Brother"),
                VocabularyWord(word: "Irmã", translation: "Sister"),
                VocabularyWord(word: "Avô", translation: "Grandfather"),
                VocabularyWord(word: "Avó", translation: "Grandmother"),
                VocabularyWord(word: "Tio", translation: "Uncle"),
                VocabularyWord(word: "Tia", translation: "Aunt")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'father'?", options: ["Pai", "Avô", "Tio", "Irmão"], correctAnswer: "Pai"),
                QuizQuestion(question: "What does 'Mãe' mean in English?", options: ["Sister", "Mother", "Aunt", "Grandmother"], correctAnswer: "Mother"),
                QuizQuestion(question: "What is the Portuguese word for 'brother'?", options: ["Irmão", "Pai", "Tio", "Avô"], correctAnswer: "Irmão"),
                QuizQuestion(question: "What is the translation of 'Irmã'?", options: ["Sister", "Mother", "Aunt", "Grandmother"], correctAnswer: "Sister"),
                QuizQuestion(question: "Which family member means 'grandfather' in Portuguese?", options: ["Avó", "Tio", "Avô", "Pai"], correctAnswer: "Avô"),
                QuizQuestion(question: "What does 'Avó' mean in English?", options: ["Grandfather", "Grandmother", "Mother", "Aunt"], correctAnswer: "Grandmother"),
                QuizQuestion(question: "What is the Portuguese word for 'uncle'?", options: ["Tio", "Avô", "Pai", "Irmão"], correctAnswer: "Tio"),
                QuizQuestion(question: "Which family member means 'aunt'?", options: ["Irmã", "Tia", "Mãe", "Avó"], correctAnswer: "Tia"),
                QuizQuestion(question: "What is the Portuguese word for 'sister'?", options: ["Irmã", "Tia", "Avó", "Mãe"], correctAnswer: "Irmã"),
                QuizQuestion(question: "What does 'Tio' mean in English?", options: ["Father", "Uncle", "Grandfather", "Brother"], correctAnswer: "Uncle")
            ],
            lesson: """
            Learn the words for family members in Portuguese: Pai (Father), Mãe (Mother), Irmão (Brother), Irmã (Sister), Avô (Grandfather), Avó (Grandmother), Tio (Uncle), and Tia (Aunt).
            """
        ),

        Topic(
            title: "Food and Drink",
            vocabulary: [
                VocabularyWord(word: "Água", translation: "Water"),
                VocabularyWord(word: "Pão", translation: "Bread"),
                VocabularyWord(word: "Leite", translation: "Milk"),
                VocabularyWord(word: "Carne", translation: "Meat"),
                VocabularyWord(word: "Fruta", translation: "Fruit"),
                VocabularyWord(word: "Café", translation: "Coffee"),
                VocabularyWord(word: "Peixe", translation: "Fish"),
                VocabularyWord(word: "Ovo", translation: "Egg")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'water'?", options: ["Café", "Água", "Leite", "Pão"], correctAnswer: "Água"),
                QuizQuestion(question: "What does 'Pão' mean in English?", options: ["Water", "Bread", "Fish", "Fruit"], correctAnswer: "Bread"),
                QuizQuestion(question: "What is the Portuguese word for 'milk'?", options: ["Água", "Leite", "Carne", "Ovo"], correctAnswer: "Leite"),
                QuizQuestion(question: "What is the translation of 'Carne'?", options: ["Egg", "Meat", "Bread", "Coffee"], correctAnswer: "Meat"),
                QuizQuestion(question: "Which word means 'fruit' in Portuguese?", options: ["Fruta", "Peixe", "Café", "Ovo"], correctAnswer: "Fruta"),
                QuizQuestion(question: "What does 'Café' mean in English?", options: ["Egg", "Milk", "Water", "Coffee"], correctAnswer: "Coffee"),
                QuizQuestion(question: "What is the Portuguese word for 'fish'?", options: ["Ovo", "Peixe", "Carne", "Fruta"], correctAnswer: "Peixe"),
                QuizQuestion(question: "Which word means 'egg'?", options: ["Ovo", "Pão", "Fruta", "Leite"], correctAnswer: "Ovo"),
                QuizQuestion(question: "What is the Portuguese word for 'meat'?", options: ["Carne", "Água", "Fruta", "Peixe"], correctAnswer: "Carne"),
                QuizQuestion(question: "What does 'Peixe' mean in English?", options: ["Fish", "Meat", "Coffee", "Bread"], correctAnswer: "Fish")
            ],
            lesson: """
            In this topic, you will learn the names of common food and drinks: Água (Water), Pão (Bread), Leite (Milk), Carne (Meat), Fruta (Fruit), Café (Coffee), Peixe (Fish), and Ovo (Egg).
            """
        ),
        Topic(
            title: "Common Adjectives",
            vocabulary: [
                VocabularyWord(word: "Grande", translation: "Big"),
                VocabularyWord(word: "Pequeno", translation: "Small"),
                VocabularyWord(word: "Bonito", translation: "Beautiful"),
                VocabularyWord(word: "Feio", translation: "Ugly"),
                VocabularyWord(word: "Feliz", translation: "Happy"),
                VocabularyWord(word: "Triste", translation: "Sad"),
                VocabularyWord(word: "Interessante", translation: "Interesting"),
                VocabularyWord(word: "Chato", translation: "Boring"),
                VocabularyWord(word: "Legal", translation: "Cool"),
                VocabularyWord(word: "Bom", translation: "Good")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'big'?", options: ["Pequeno", "Grande", "Legal", "Bonito"], correctAnswer: "Grande"),
                QuizQuestion(question: "What does 'Pequeno' mean in English?", options: ["Small", "Big", "Good", "Interesting"], correctAnswer: "Small"),
                QuizQuestion(question: "What is the Portuguese word for 'beautiful'?", options: ["Feio", "Bonito", "Triste", "Chato"], correctAnswer: "Bonito"),
                QuizQuestion(question: "What is the translation of 'Feio'?", options: ["Happy", "Ugly", "Sad", "Cool"], correctAnswer: "Ugly"),
                QuizQuestion(question: "Which word means 'happy' in Portuguese?", options: ["Triste", "Legal", "Feliz", "Interessante"], correctAnswer: "Feliz"),
                QuizQuestion(question: "What does 'Triste' mean in English?", options: ["Sad", "Interesting", "Beautiful", "Boring"], correctAnswer: "Sad"),
                QuizQuestion(question: "What is the Portuguese word for 'interesting'?", options: ["Chato", "Bom", "Interessante", "Feliz"], correctAnswer: "Interessante"),
                QuizQuestion(question: "What does 'Chato' mean in English?", options: ["Cool", "Good", "Boring", "Beautiful"], correctAnswer: "Boring"),
                QuizQuestion(question: "Which word means 'cool' in Portuguese?", options: ["Legal", "Triste", "Pequeno", "Grande"], correctAnswer: "Legal"),
                QuizQuestion(question: "What is the Portuguese word for 'good'?", options: ["Bom", "Feio", "Interessante", "Chato"], correctAnswer: "Bom")
            ],
            lesson: """
            In this lesson, you will learn common adjectives in Portuguese: Grande (Big), Pequeno (Small), Bonito (Beautiful), Feio (Ugly), Feliz (Happy), Triste (Sad), Interessante (Interesting), Chato (Boring), Legal (Cool), and Bom (Good).
            """
        ),

        Topic(
            title: "Days of the Week",
            vocabulary: [
                VocabularyWord(word: "Segunda-feira", translation: "Monday"),
                VocabularyWord(word: "Terça-feira", translation: "Tuesday"),
                VocabularyWord(word: "Quarta-feira", translation: "Wednesday"),
                VocabularyWord(word: "Quinta-feira", translation: "Thursday"),
                VocabularyWord(word: "Sexta-feira", translation: "Friday"),
                VocabularyWord(word: "Sábado", translation: "Saturday"),
                VocabularyWord(word: "Domingo", translation: "Sunday"),
                VocabularyWord(word: "Semana", translation: "Week")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese word for 'Monday'?", options: ["Sábado", "Terça-feira", "Segunda-feira", "Domingo"], correctAnswer: "Segunda-feira"),
                QuizQuestion(question: "What does 'Terça-feira' mean in English?", options: ["Wednesday", "Tuesday", "Thursday", "Friday"], correctAnswer: "Tuesday"),
                QuizQuestion(question: "What is the Portuguese term for 'Wednesday'?", options: ["Quarta-feira", "Segunda-feira", "Domingo", "Sábado"], correctAnswer: "Quarta-feira"),
                QuizQuestion(question: "What is the translation of 'Quinta-feira'?", options: ["Friday", "Saturday", "Thursday", "Monday"], correctAnswer: "Thursday"),
                QuizQuestion(question: "Which word means 'Friday' in Portuguese?", options: ["Sábado", "Sexta-feira", "Terça-feira", "Quarta-feira"], correctAnswer: "Sexta-feira"),
                QuizQuestion(question: "What does 'Sábado' mean in English?", options: ["Sunday", "Saturday", "Week", "Monday"], correctAnswer: "Saturday"),
                QuizQuestion(question: "What is the Portuguese word for 'Sunday'?", options: ["Semana", "Sábado", "Domingo", "Sexta-feira"], correctAnswer: "Domingo"),
                QuizQuestion(question: "What does 'Semana' mean in English?", options: ["Week", "Monday", "Friday", "Thursday"], correctAnswer: "Week"),
                QuizQuestion(question: "Which word means 'Thursday'?", options: ["Quarta-feira", "Sexta-feira", "Quinta-feira", "Terça-feira"], correctAnswer: "Quinta-feira"),
                QuizQuestion(question: "What is the Portuguese word for 'Tuesday'?", options: ["Segunda-feira", "Terça-feira", "Quarta-feira", "Domingo"], correctAnswer: "Terça-feira")
            ],
            lesson: """
            Learn the days of the week in Portuguese: Segunda-feira (Monday), Terça-feira (Tuesday), Quarta-feira (Wednesday), Quinta-feira (Thursday), Sexta-feira (Friday), Sábado (Saturday), Domingo (Sunday), and Semana (Week).
            """
        ),

        Topic(
            title: "Weather Vocabulary",
            vocabulary: [
                VocabularyWord(word: "Está ensolarado", translation: "It's sunny"),
                VocabularyWord(word: "Está frio", translation: "It's cold"),
                VocabularyWord(word: "Está nublado", translation: "It's cloudy"),
                VocabularyWord(word: "Está chovendo", translation: "It's raining"),
                VocabularyWord(word: "Está nevando", translation: "It's snowing"),
                VocabularyWord(word: "Está calor", translation: "It's hot"),
                VocabularyWord(word: "Clima", translation: "Weather")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese phrase for 'It's sunny'?", options: ["Está frio", "Está ensolarado", "Está chovendo", "Está nublado"], correctAnswer: "Está ensolarado"),
                QuizQuestion(question: "What does 'Está frio' mean in English?", options: ["It's hot", "It's cold", "It's cloudy", "It's snowing"], correctAnswer: "It's cold"),
                QuizQuestion(question: "What is the Portuguese phrase for 'It's cloudy'?", options: ["Está nublado", "Está frio", "Está ensolarado", "Está chovendo"], correctAnswer: "Está nublado"),
                QuizQuestion(question: "What is the translation of 'Está chovendo'?", options: ["It's sunny", "It's raining", "It's snowing", "It's cold"], correctAnswer: "It's raining"),
                QuizQuestion(question: "Which phrase means 'It's snowing' in Portuguese?", options: ["Está ensolarado", "Está frio", "Está nevando", "Está chovendo"], correctAnswer: "Está nevando"),
                QuizQuestion(question: "What does 'Está calor' mean in English?", options: ["It's cold", "It's hot", "It's cloudy", "It's sunny"], correctAnswer: "It's hot"),
                QuizQuestion(question: "What is the Portuguese word for 'weather'?", options: ["Clima", "Tempo", "Estação", "Frio"], correctAnswer: "Clima"),
                QuizQuestion(question: "What does 'Está nublado' mean?", options: ["It's snowing", "It's sunny", "It's cloudy", "It's hot"], correctAnswer: "It's cloudy"),
                QuizQuestion(question: "Which phrase means 'It's raining'?", options: ["Está frio", "Está chovendo", "Está ensolarado", "Está calor"], correctAnswer: "Está chovendo"),
                QuizQuestion(question: "What is the Portuguese phrase for 'It's cold'?", options: ["Está calor", "Está nublado", "Está frio", "Está ensolarado"], correctAnswer: "Está frio")
            ],
            lesson: """
            In this topic, you will learn common weather phrases: Está ensolarado (It's sunny), Está frio (It's cold), Está nublado (It's cloudy), Está chovendo (It's raining), Está nevando (It's snowing), Está calor (It's hot), and Clima (Weather).
            """
        ),
        Topic(
            title: "Common Verbs",
            vocabulary: [
                VocabularyWord(word: "Ser", translation: "To be (permanent)"),
                VocabularyWord(word: "Estar", translation: "To be (temporary)"),
                VocabularyWord(word: "Ter", translation: "To have"),
                VocabularyWord(word: "Fazer", translation: "To do/make"),
                VocabularyWord(word: "Ir", translation: "To go"),
                VocabularyWord(word: "Comer", translation: "To eat"),
                VocabularyWord(word: "Beber", translation: "To drink"),
                VocabularyWord(word: "Falar", translation: "To speak"),
                VocabularyWord(word: "Saber", translation: "To know"),
                VocabularyWord(word: "Poder", translation: "To can")
            ],
            QuizQuestions: [
                QuizQuestion(question: "What is the Portuguese verb for 'to be' (permanent)?", options: ["Estar", "Ter", "Ser", "Ir"], correctAnswer: "Ser"),
                QuizQuestion(question: "What does 'Estar' mean in English?", options: ["To have", "To be (temporary)", "To go", "To eat"], correctAnswer: "To be (temporary)"),
                QuizQuestion(question: "What is the Portuguese verb for 'to have'?", options: ["Fazer", "Ir", "Ter", "Saber"], correctAnswer: "Ter"),
                QuizQuestion(question: "What is the translation of 'Fazer'?", options: ["To make/do", "To drink", "To speak", "To eat"], correctAnswer: "To make/do"),
                QuizQuestion(question: "Which verb means 'to go' in Portuguese?", options: ["Comer", "Ir", "Poder", "Falar"], correctAnswer: "Ir"),
                QuizQuestion(question: "What does 'Comer' mean in English?", options: ["To eat", "To drink", "To know", "To be"], correctAnswer: "To eat"),
                QuizQuestion(question: "What is the Portuguese word for 'to drink'?", options: ["Beber", "Falar", "Fazer", "Saber"], correctAnswer: "Beber"),
                QuizQuestion(question: "What does 'Falar' mean?", options: ["To speak", "To go", "To have", "To know"], correctAnswer: "To speak"),
                QuizQuestion(question: "Which verb means 'to know' in Portuguese?", options: ["Poder", "Saber", "Estar", "Ter"], correctAnswer: "Saber"),
                QuizQuestion(question: "What is the Portuguese verb for 'can'?", options: ["Fazer", "Poder", "Ir", "Ser"], correctAnswer: "Poder")
            ],
            lesson: """
            In this lesson, you will learn common verbs in Portuguese: Ser (To be - permanent), Estar (To be - temporary), Ter (To have), Fazer (To do/make), Ir (To go), Comer (To eat), Beber (To drink), Falar (To speak), Saber (To know), and Poder (To can).
            """
        )
    ]
    
    
    //MARK: - Helpers
    
    // Handle quiz scoring and time bonus
    func handleQuizAnswer(isCorrect: Bool, elapsedTime: Int) {
        if isCorrect {
            score += 10
            let bonus = max(0, (20 - elapsedTime) / 2)
            timeBonus += bonus
            score += bonus
        }
        // Move to the next question or finish quiz
    }
    
    //MARK: - Private Helpers

}


