import SwiftUI

struct SentenceQuizView: View {
    @StateObject private var speechManager = SpeechManager()
    @State private var sentences = KoreanSentenceData.sentences
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String?
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var score = 0
    @State private var totalQuestions = 0
    @State private var quizType: QuizType = .translation
    @State private var showQuizTypeSelector = false
    @State private var selectedDifficulty: KoreanSentence.DifficultyLevel = .beginner
    @State private var selectedCategory: KoreanSentence.SentenceCategory = .daily
    
    enum QuizType: String, CaseIterable {
        case translation = "翻訳クイズ"
        case fillBlank = "穴埋めクイズ"
        case listening = "リスニングクイズ"
        
        var description: String {
            switch self {
            case .translation:
                return "韓国語文章の日本語訳を選ぶ"
            case .fillBlank:
                return "文章の空欄を埋める"
            case .listening:
                return "音声を聞いて正しい文章を選ぶ"
            }
        }
    }
    
    private var filteredSentences: [KoreanSentence] {
        sentences.filter { sentence in
            sentence.difficulty == selectedDifficulty && sentence.category == selectedCategory
        }
    }
    
    private var currentQuestion: QuizQuestion? {
        guard !filteredSentences.isEmpty else { return nil }
        let sentence = filteredSentences[currentQuestionIndex % filteredSentences.count]
        return createQuestion(from: sentence, type: quizType)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if showQuizTypeSelector {
                    quizTypeSelectorView
                } else if let question = currentQuestion {
                    quizView(question: question)
                } else {
                    noQuestionsView
                }
            }
            .padding(20)
            .navigationTitle("長文クイズ")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("設定") {
                        showQuizTypeSelector = true
                    }
                }
            }
        }
    }
    
    private var quizTypeSelectorView: some View {
        VStack(spacing: 30) {
            Text("クイズ設定")
                .font(.title)
                .fontWeight(.bold)
            
            // クイズタイプ選択
            VStack(alignment: .leading, spacing: 15) {
                Text("クイズタイプ")
                    .font(.headline)
                
                ForEach(QuizType.allCases, id: \.self) { type in
                    Button(action: {
                        quizType = type
                    }) {
                        HStack {
                            Text(type.rawValue)
                                .foregroundColor(quizType == type ? .white : .primary)
                            Spacer()
                            if quizType == type {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(quizType == type ? Color.blue : Color(.systemGray6))
                        .cornerRadius(10)
                    }
                }
            }
            
            // 難易度選択
            VStack(alignment: .leading, spacing: 15) {
                Text("難易度")
                    .font(.headline)
                
                Picker("難易度", selection: $selectedDifficulty) {
                    ForEach(KoreanSentence.DifficultyLevel.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            // カテゴリ選択
            VStack(alignment: .leading, spacing: 15) {
                Text("カテゴリ")
                    .font(.headline)
                
                Picker("カテゴリ", selection: $selectedCategory) {
                    ForEach(KoreanSentence.SentenceCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            // 開始ボタン
            Button(action: {
                startQuiz()
            }) {
                Text("クイズ開始")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .disabled(filteredSentences.isEmpty)
            
            Spacer()
        }
    }
    
    private func quizView(question: QuizQuestion) -> some View {
        VStack(spacing: 30) {
            // 進捗表示
            ProgressView(value: Double(currentQuestionIndex + 1), total: Double(totalQuestions))
                .progressViewStyle(LinearProgressViewStyle())
                .padding(.horizontal)
            
            Text("\(currentQuestionIndex + 1) / \(totalQuestions)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            // 問題表示
            VStack(spacing: 20) {
                Text(question.question)
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if quizType == .listening {
                    Button(action: {
                        speechManager.speakKorean(question.correctAnswer)
                    }) {
                        HStack {
                            Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                            Text("音声を再生")
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .disabled(!speechManager.isAvailable)
                }
            }
            
            // 選択肢
            VStack(spacing: 15) {
                ForEach(question.options, id: \.self) { option in
                    Button(action: {
                        if !showResult {
                            selectedAnswer = option
                            checkAnswer()
                        }
                    }) {
                        HStack {
                            Text(option)
                                .foregroundColor(answerColor(for: option))
                                .multilineTextAlignment(.leading)
                            Spacer()
                            if showResult && option == question.correctAnswer {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else if showResult && option == selectedAnswer && option != question.correctAnswer {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(answerBackgroundColor(for: option))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(answerBorderColor(for: option), lineWidth: 2)
                        )
                    }
                    .disabled(showResult)
                }
            }
            
            // 結果表示
            if showResult {
                VStack(spacing: 15) {
                    Text(isCorrect ? "正解！" : "不正解")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(isCorrect ? .green : .red)
                    
                    if !isCorrect {
                        Text("正解: \(question.correctAnswer)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: nextQuestion) {
                        Text(currentQuestionIndex < totalQuestions - 1 ? "次の問題" : "結果を見る")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
            }
            
            Spacer()
        }
    }
    
    private var noQuestionsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("問題が見つかりません")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("設定を変更してください")
                .font(.body)
                .foregroundColor(.secondary)
            
            Button(action: {
                showQuizTypeSelector = true
            }) {
                Text("設定に戻る")
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
            }
        }
    }
    
    private func startQuiz() {
        currentQuestionIndex = 0
        score = 0
        totalQuestions = min(10, filteredSentences.count)
        showQuizTypeSelector = false
        showResult = false
        selectedAnswer = nil
    }
    
    private func checkAnswer() {
        guard let question = currentQuestion else { return }
        isCorrect = selectedAnswer == question.correctAnswer
        if isCorrect {
            score += 1
        }
        showResult = true
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < totalQuestions - 1 {
            currentQuestionIndex += 1
            showResult = false
            selectedAnswer = nil
        } else {
            // クイズ終了
            showQuizTypeSelector = true
        }
    }
    
    private func answerColor(for option: String) -> Color {
        guard showResult, let question = currentQuestion else { return .primary }
        
        if option == question.correctAnswer {
            return .green
        } else if option == selectedAnswer && option != question.correctAnswer {
            return .red
        }
        return .primary
    }
    
    private func answerBackgroundColor(for option: String) -> Color {
        guard showResult, let question = currentQuestion else { return Color(.systemGray6) }
        
        if option == question.correctAnswer {
            return Color.green.opacity(0.1)
        } else if option == selectedAnswer && option != question.correctAnswer {
            return Color.red.opacity(0.1)
        }
        return Color(.systemGray6)
    }
    
    private func answerBorderColor(for option: String) -> Color {
        guard showResult, let question = currentQuestion else { return Color.clear }
        
        if option == question.correctAnswer {
            return .green
        } else if option == selectedAnswer && option != question.correctAnswer {
            return .red
        }
        return Color.clear
    }
    
    private func createQuestion(from sentence: KoreanSentence, type: QuizType) -> QuizQuestion {
        switch type {
        case .translation:
            return createTranslationQuestion(from: sentence)
        case .fillBlank:
            return createFillBlankQuestion(from: sentence)
        case .listening:
            return createListeningQuestion(from: sentence)
        }
    }
    
    private func createTranslationQuestion(from sentence: KoreanSentence) -> QuizQuestion {
        let options = [
            sentence.japanese,
            getRandomJapaneseTranslation(),
            getRandomJapaneseTranslation(),
            getRandomJapaneseTranslation()
        ].shuffled()
        
        return QuizQuestion(
            question: "この韓国語の日本語訳は？\n\n\(sentence.korean)",
            options: options,
            correctAnswer: sentence.japanese
        )
    }
    
    private func createFillBlankQuestion(from sentence: KoreanSentence) -> QuizQuestion {
        let words = sentence.korean.components(separatedBy: " ")
        guard words.count > 2 else {
            return createTranslationQuestion(from: sentence)
        }
        
        let randomIndex = Int.random(in: 0..<words.count)
        let correctWord = words[randomIndex]
        var modifiedWords = words
        modifiedWords[randomIndex] = "_____"
        
        let options = [
            correctWord,
            getRandomKoreanWord(),
            getRandomKoreanWord(),
            getRandomKoreanWord()
        ].shuffled()
        
        return QuizQuestion(
            question: "空欄に入る単語は？\n\n\(modifiedWords.joined(separator: " "))",
            options: options,
            correctAnswer: correctWord
        )
    }
    
    private func createListeningQuestion(from sentence: KoreanSentence) -> QuizQuestion {
        let options = [
            sentence.korean,
            getRandomKoreanSentence(),
            getRandomKoreanSentence(),
            getRandomKoreanSentence()
        ].shuffled()
        
        return QuizQuestion(
            question: "音声で聞いた文章を選んでください",
            options: options,
            correctAnswer: sentence.korean
        )
    }
    
    private func getRandomJapaneseTranslation() -> String {
        let translations = [
            "こんにちは、お元気ですか？",
            "今日はとても良い天気ですね。",
            "韓国料理が大好きです。",
            "友達と一緒に映画を見に行きます。",
            "会社に通勤しています。"
        ]
        return translations.randomElement() ?? "翻訳が見つかりません"
    }
    
    private func getRandomKoreanWord() -> String {
        let words = ["안녕하세요", "감사합니다", "사랑해요", "미안해요", "좋아요"]
        return words.randomElement() ?? "단어"
    }
    
    private func getRandomKoreanSentence() -> String {
        let sentences = [
            "안녕하세요, 만나서 반갑습니다.",
            "오늘 날씨가 정말 좋네요.",
            "한국 음식을 좋아해요.",
            "친구와 함께 영화를 봐요.",
            "회사에 다니고 있어요."
        ]
        return sentences.randomElement() ?? "문장이 없습니다"
    }
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: String
}
