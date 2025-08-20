//
//  ChineseQuizView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct ChineseQuizView: View {
    @State private var quizCharacters: [ChineseCharacter] = []
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showResult = false
    @State private var correctAnswers = 0
    @State private var isQuizFinished = false
    @State private var selectedCategory: ChineseCharacter.CharacterCategory = .basic
    @State private var quizSize = 10
    @State private var quizMode: QuizMode = .meaningToCharacter
    
    private let quizSizes = [5, 10, 15, 20]
    
    enum QuizMode: String, CaseIterable {
        case meaningToCharacter = "意味→漢字"
        case characterToMeaning = "漢字→意味"
        case pinyinToCharacter = "拼音→漢字"
        case characterToPinyin = "漢字→拼音"
    }
    
    private var currentQuestion: ChineseCharacter? {
        guard currentQuestionIndex < quizCharacters.count else { return nil }
        return quizCharacters[currentQuestionIndex]
    }
    
    private var questionText: String {
        guard let current = currentQuestion else { return "" }
        switch quizMode {
        case .meaningToCharacter:
            return current.japanese
        case .characterToMeaning:
            return current.character
        case .pinyinToCharacter:
            return current.pinyin
        case .characterToPinyin:
            return current.character
        }
    }
    
    private var correctAnswer: String {
        guard let current = currentQuestion else { return "" }
        switch quizMode {
        case .meaningToCharacter:
            return current.character
        case .characterToMeaning:
            return current.japanese
        case .pinyinToCharacter:
            return current.character
        case .characterToPinyin:
            return current.pinyin
        }
    }
    
    private var answerChoices: [String] {
        guard let current = currentQuestion else { return [] }
        
        var choices = [correctAnswer]
        
        // 同じカテゴリの他の文字から3つの不正解を追加
        let otherCharacters = ChineseCharacterData.characters(for: current.category)
            .filter { character in
                switch quizMode {
                case .meaningToCharacter:
                    return character.character != current.character
                case .characterToMeaning:
                    return character.japanese != current.japanese
                case .pinyinToCharacter:
                    return character.character != current.character
                case .characterToPinyin:
                    return character.pinyin != current.pinyin
                }
            }
            .shuffled()
            .prefix(3)
            .map { character in
                switch quizMode {
                case .meaningToCharacter:
                    return character.character
                case .characterToMeaning:
                    return character.japanese
                case .pinyinToCharacter:
                    return character.character
                case .characterToPinyin:
                    return character.pinyin
                }
            }
        
        choices.append(contentsOf: otherCharacters)
        
        // 足りない場合は他のカテゴリからも追加
        if choices.count < 4 {
            let moreCharacters = ChineseCharacterData.characters
                .filter { !choices.contains(getAnswerFromCharacter($0)) }
                .shuffled()
                .prefix(4 - choices.count)
                .map { getAnswerFromCharacter($0) }
            choices.append(contentsOf: moreCharacters)
        }
        
        return choices.shuffled()
    }
    
    private func getAnswerFromCharacter(_ character: ChineseCharacter) -> String {
        switch quizMode {
        case .meaningToCharacter:
            return character.character
        case .characterToMeaning:
            return character.japanese
        case .pinyinToCharacter:
            return character.character
        case .characterToPinyin:
            return character.pinyin
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if quizCharacters.isEmpty {
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
            .navigationTitle("漢字クイズ")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private var setupView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Text("漢字クイズ設定")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // クイズモード選択
                VStack(alignment: .leading, spacing: 10) {
                    Text("クイズモード")
                        .font(.headline)
                    
                    Picker("クイズモード", selection: $quizMode) {
                        ForEach(QuizMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // カテゴリ選択
                VStack(alignment: .leading, spacing: 10) {
                    Text("カテゴリ")
                        .font(.headline)
                    
                    Picker("カテゴリ", selection: $selectedCategory) {
                        ForEach(ChineseCharacter.CharacterCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
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
                    Text("問題 \(currentQuestionIndex + 1) / \(quizCharacters.count)")
                        .font(.headline)
                    Spacer()
                    Text("正解: \(correctAnswers)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                ProgressView(value: Double(currentQuestionIndex + 1), total: Double(quizCharacters.count))
                    .padding(.horizontal)
            }
            
            Spacer()
            
            if let question = currentQuestion {
                // 問題カード
                VStack(spacing: 25) {
                    Text("この\(quizMode.rawValue.split(separator: "→")[0])は？")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(questionText)
                        .font(.system(size: 48, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // 追加情報表示
                    if quizMode == .characterToMeaning || quizMode == .characterToPinyin {
                        Text("(\(question.pinyin))")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.orange)
                    }
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
                                    (choice == correctAnswer ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) :
                                    Color(.systemBackground)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            selectedAnswer == choice && showResult ?
                                            (choice == correctAnswer ? Color.green : Color.red) :
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
                    Text(currentQuestionIndex < quizCharacters.count - 1 ? "次の問題" : "結果を見る")
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
                
                Text("\(correctAnswers) / \(quizCharacters.count) 問正解")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                let percentage = Double(correctAnswers) / Double(quizCharacters.count) * 100
                Text("\(Int(percentage))%")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(percentage >= 80 ? .green : percentage >= 60 ? .orange : .red)
                
                if percentage >= 80 {
                    Text("素晴らしい！加油！")
                        .font(.title3)
                        .foregroundColor(.green)
                } else if percentage >= 60 {
                    Text("良い結果です！继续努力！")
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
        let categoryCharacters = ChineseCharacterData.characters(for: selectedCategory)
        quizCharacters = Array(categoryCharacters.shuffled().prefix(min(quizSize, categoryCharacters.count)))
        currentQuestionIndex = 0
        correctAnswers = 0
        selectedAnswer = nil
        showResult = false
        isQuizFinished = false
    }
    
    private func nextQuestion() {
        if selectedAnswer == correctAnswer {
            correctAnswers += 1
        }
        
        if currentQuestionIndex < quizCharacters.count - 1 {
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
        quizCharacters = []
        currentQuestionIndex = 0
        correctAnswers = 0
        selectedAnswer = nil
        showResult = false
        isQuizFinished = false
    }
}

#Preview {
    ChineseQuizView()
}
