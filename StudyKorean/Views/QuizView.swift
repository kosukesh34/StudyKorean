//
//  QuizView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var progressManager = StudyProgressManager()
    @StateObject private var speechManager = SpeechManager()
    @State private var quizWords: [KoreanWord] = []
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showResult = false
    @State private var correctAnswers = 0
    @State private var isQuizFinished = false
    @State private var selectedCategory: KoreanWord.WordCategory = .greetings
    @State private var selectedMasteryLevel: WordMastery.MasteryLevel? = nil
    @State private var quizSize = 10
    
    private let quizSizes = [5, 10, 15, 20]
    
    private var currentQuestion: KoreanWord? {
        guard currentQuestionIndex < quizWords.count else { return nil }
        return quizWords[currentQuestionIndex]
    }
    
    private var answerChoices: [String] {
        guard let current = currentQuestion else { return [] }
        
        // 正解を含む4つの選択肢を作成
        var choices = [current.japanese]
        
        // 同じカテゴリの他の単語から3つの不正解を追加
        let otherWords = KoreanWordData.words(for: current.category)
            .filter { $0.japanese != current.japanese }
            .shuffled()
            .prefix(3)
            .map { $0.japanese }
        
        choices.append(contentsOf: otherWords)
        
        // 足りない場合は他のカテゴリからも追加
        if choices.count < 4 {
            let moreWords = KoreanWordData.words
                .filter { !choices.contains($0.japanese) }
                .shuffled()
                .prefix(4 - choices.count)
                .map { $0.japanese }
            choices.append(contentsOf: moreWords)
        }
        
        return choices.shuffled()
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if quizWords.isEmpty {
                    // クイズ設定画面
                    setupView
                } else if isQuizFinished {
                    // 結果画面
                    resultView
                } else {
                    // クイズ画面
                    quizView
                }
            }
            .navigationTitle("クイズ")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private var setupView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Text("クイズ設定")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // カテゴリ選択
                VStack(alignment: .leading, spacing: 10) {
                    Text("カテゴリ")
                        .font(.headline)
                    
                    Picker("カテゴリ", selection: $selectedCategory) {
                        ForEach(KoreanWord.WordCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                }
                
                // 習熟度フィルター
                VStack(alignment: .leading, spacing: 10) {
                    Text("習熟度")
                        .font(.headline)
                    
                    Picker("習熟度", selection: $selectedMasteryLevel) {
                        Text("すべて").tag(nil as WordMastery.MasteryLevel?)
                        ForEach(WordMastery.MasteryLevel.allCases, id: \.self) { level in
                            Text(level.rawValue).tag(level as WordMastery.MasteryLevel?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                }
                
                // 問題数選択
                VStack(alignment: .leading, spacing: 10) {
                    Text("問題数")
                        .font(.headline)
                    
                    Picker("問題数", selection: $quizSize) {
                        ForEach(quizSizes, id: \.self) { size in
                            Text("\(size)問").tag(size)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .padding(30)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: startQuiz) {
                Text("クイズを始める")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .padding(.bottom, 30)
        }
    }
    
    private var quizView: some View {
        VStack(spacing: 30) {
            // 進行状況
            VStack(spacing: 10) {
                HStack {
                    Text("問題 \(currentQuestionIndex + 1) / \(quizWords.count)")
                        .font(.headline)
                    Spacer()
                    Text("正解: \(correctAnswers)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                ProgressView(value: Double(currentQuestionIndex + 1), total: Double(quizWords.count))
                    .padding(.horizontal)
            }
            
            Spacer()
            
            if let question = currentQuestion {
                // 問題カード
                VStack(spacing: 25) {
                    Text("この韓国語の意味は？")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(question.korean)
                            .font(.system(size: 48, weight: .medium))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        // 音声再生ボタン
                        Button(action: {
                            speechManager.speakKorean(question.korean)
                        }) {
                            Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .scaleEffect(speechManager.isSpeaking ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: speechManager.isSpeaking)
                        }
                        .disabled(!speechManager.isAvailable)
                    }
                    
                    Text(question.pronunciation)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
                // 選択肢
                VStack(spacing: 15) {
                    ForEach(answerChoices, id: \.self) { choice in
                        Button(action: {
                            selectedAnswer = choice
                            showResult = true
                        }) {
                            Text(choice)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(
                                    selectedAnswer == choice && showResult ?
                                    (choice == question.japanese ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) :
                                    Color(.systemBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            selectedAnswer == choice && showResult ?
                                            (choice == question.japanese ? Color.green : Color.red) :
                                            Color(.systemGray4),
                                            lineWidth: selectedAnswer == choice && showResult ? 2 : 1
                                        )
                                )
                                .cornerRadius(10)
                        }
                        .disabled(showResult)
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
            
            // 次へボタン
            if showResult {
                Button(action: nextQuestion) {
                    Text(currentQuestionIndex < quizWords.count - 1 ? "次の問題" : "結果を見る")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    private var resultView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Text("クイズ完了！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(correctAnswers) / \(quizWords.count) 問正解")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                let percentage = Double(correctAnswers) / Double(quizWords.count) * 100
                Text("\(Int(percentage))%")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(percentage >= 80 ? .green : percentage >= 60 ? .orange : .red)
                
                if percentage >= 80 {
                    Text("素晴らしい！")
                        .font(.title3)
                        .foregroundColor(.green)
                } else if percentage >= 60 {
                    Text("良い結果です！")
                        .font(.title3)
                        .foregroundColor(.orange)
                } else {
                    Text("もう一度挑戦してみましょう！")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            .padding(40)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: restartQuiz) {
                    Text("もう一度挑戦")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                
                Button(action: resetQuiz) {
                    Text("設定に戻る")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(25)
                }
            }
            .padding(.bottom, 30)
        }
    }
    
    private func startQuiz() {
        var availableWords = KoreanWordData.words(for: selectedCategory)
        
        // 習熟度フィルターを適用
        if let masteryLevel = selectedMasteryLevel {
            availableWords = availableWords.filter { word in
                guard let mastery = progressManager.wordMasteries[word.id] else { return false }
                return mastery.masteryLevel == masteryLevel
            }
        }
        
        quizWords = Array(availableWords.shuffled().prefix(min(quizSize, availableWords.count)))
        currentQuestionIndex = 0
        correctAnswers = 0
        selectedAnswer = nil
        showResult = false
        isQuizFinished = false
    }
    
    private func nextQuestion() {
        guard let question = currentQuestion else { return }
        
        let isCorrect = selectedAnswer == question.japanese
        if isCorrect {
            correctAnswers += 1
        }
        
        // 進捗を記録
        progressManager.recordStudyResult(
            wordId: question.id,
            isCorrect: isCorrect,
            studyType: .quiz
        )
        
        if currentQuestionIndex < quizWords.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            showResult = false
        } else {
            isQuizFinished = true
        }
    }
    
    private func restartQuiz() {
        startQuiz()
    }
    
    private func resetQuiz() {
        quizWords = []
        currentQuestionIndex = 0
        correctAnswers = 0
        selectedAnswer = nil
        showResult = false
        isQuizFinished = false
    }
}

#Preview {
    QuizView()
}
