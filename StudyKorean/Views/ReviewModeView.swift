//
//  ReviewModeView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct ReviewModeView: View {
    @ObservedObject var progressManager: StudyProgressManager
    @StateObject private var speechManager = SpeechManager()
    @Environment(\.dismiss) private var dismiss
    
    @State private var reviewWords: [KoreanWord] = []
    @State private var currentIndex = 0
    @State private var showAnswer = false
    @State private var userAnswer = ""
    @State private var isCorrect = false
    @State private var showingResult = false
    @State private var correctCount = 0
    @State private var reviewCompleted = false
    
    private var currentWord: KoreanWord? {
        guard currentIndex < reviewWords.count else { return nil }
        return reviewWords[currentIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if reviewWords.isEmpty {
                    setupView
                } else if reviewCompleted {
                    resultView
                } else {
                    reviewView
                }
            }
            .navigationTitle("復習モード")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private var setupView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "arrow.clockwise.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                
                Text("復習モード")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("間違えた単語や習得できていない単語を重点的に復習します")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            let reviewWords = progressManager.getWordsForReview()
            
            VStack(spacing: 15) {
                Text("復習対象: \(reviewWords.count)単語")
                    .font(.headline)
                
                if !reviewWords.isEmpty {
                    Button("復習を始める") {
                        startReview()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(Color.orange)
                    .cornerRadius(25)
                } else {
                    Text("復習対象の単語がありません")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(30)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button("閉じる") {
                dismiss()
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.blue)
            .padding(.bottom, 30)
        }
    }
    
    private var reviewView: some View {
        VStack(spacing: 30) {
            // 進行状況
            VStack(spacing: 10) {
                HStack {
                    Text("問題 \(currentIndex + 1) / \(reviewWords.count)")
                        .font(.headline)
                    Spacer()
                    Text("正解: \(correctCount)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                
                ProgressView(value: Double(currentIndex + 1), total: Double(reviewWords.count))
                    .padding(.horizontal)
            }
            
            Spacer()
            
            if let word = currentWord {
                // 問題カード
                VStack(spacing: 25) {
                    Text("この韓国語の意味は？")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(word.korean)
                            .font(.system(size: 48, weight: .medium))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        // 音声再生ボタン
                        Button(action: {
                            speechManager.speakKorean(word.korean)
                        }) {
                            Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .scaleEffect(speechManager.isSpeaking ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: speechManager.isSpeaking)
                        }
                        .disabled(!speechManager.isAvailable)
                    }
                    
                    Text(word.pronunciation)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    if !showAnswer {
                        // 回答入力
                        VStack(spacing: 15) {
                            TextField("日本語で回答してください", text: $userAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)
                            
                            Button("回答する") {
                                checkAnswer()
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .disabled(userAnswer.isEmpty)
                        }
                    } else {
                        // 結果表示
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.title)
                                    .foregroundColor(isCorrect ? .green : .red)
                                
                                Text(isCorrect ? "正解！" : "不正解")
                                    .font(.headline)
                                    .foregroundColor(isCorrect ? .green : .red)
                            }
                            
                            if !isCorrect {
                                Text("正解: \(word.japanese)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Button("次へ") {
                                nextQuestion()
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(25)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
    }
    
    private var resultView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Text("復習完了！")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(correctCount) / \(reviewWords.count) 問正解")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                let percentage = Double(correctCount) / Double(reviewWords.count) * 100
                Text("\(Int(percentage))%")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(percentage >= 80 ? .green : percentage >= 60 ? .orange : .red)
                
                if percentage >= 80 {
                    Text("素晴らしい復習でした！")
                        .font(.title3)
                        .foregroundColor(.green)
                } else if percentage >= 60 {
                    Text("良い復習でした！")
                        .font(.title3)
                        .foregroundColor(.orange)
                } else {
                    Text("もう一度復習してみましょう")
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
                Button("もう一度復習") {
                    startReview()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(Color.orange)
                .cornerRadius(25)
                
                Button("閉じる") {
                    dismiss()
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.blue)
            }
            .padding(.bottom, 30)
        }
    }
    
    private func startReview() {
        reviewWords = progressManager.getWordsForReview().shuffled()
        currentIndex = 0
        correctCount = 0
        userAnswer = ""
        showAnswer = false
        reviewCompleted = false
    }
    
    private func checkAnswer() {
        guard let word = currentWord else { return }
        
        // 簡単な文字列マッチング（実際のアプリではより高度なマッチングが必要）
        let normalizedUserAnswer = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedCorrectAnswer = word.japanese.trimmingCharacters(in: .whitespacesAndNewlines)
        
        isCorrect = normalizedUserAnswer == normalizedCorrectAnswer
        
        if isCorrect {
            correctCount += 1
        }
        
        // 進捗を記録
        progressManager.recordStudyResult(
            wordId: word.id,
            isCorrect: isCorrect,
            studyType: .review
        )
        
        showAnswer = true
    }
    
    private func nextQuestion() {
        if currentIndex < reviewWords.count - 1 {
            currentIndex += 1
            userAnswer = ""
            showAnswer = false
        } else {
            reviewCompleted = true
        }
    }
}

#Preview {
    ReviewModeView(progressManager: StudyProgressManager())
}
