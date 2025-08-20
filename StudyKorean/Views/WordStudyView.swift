//
//  WordStudyView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct WordStudyView: View {
    @State private var selectedCategory: KoreanWord.WordCategory = .greetings
    @State private var currentWordIndex = 0
    @State private var showJapanese = false
    @State private var showPronunciation = false
    
    private var currentWords: [KoreanWord] {
        KoreanWordData.words(for: selectedCategory)
    }
    
    private var currentWord: KoreanWord {
        guard currentWordIndex < currentWords.count else {
            return currentWords.first ?? KoreanWordData.words.first!
        }
        return currentWords[currentWordIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // カテゴリ選択
                VStack(alignment: .leading, spacing: 10) {
                    Text("カテゴリ")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(KoreanWord.WordCategory.allCases, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                    currentWordIndex = 0
                                    showJapanese = false
                                    showPronunciation = false
                                }) {
                                    Text(category.rawValue)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedCategory == category ? .white : .blue)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(selectedCategory == category ? Color.blue : Color.blue.opacity(0.1))
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // 進行状況
                VStack {
                    Text("\(currentWordIndex + 1) / \(currentWords.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: Double(currentWordIndex + 1), total: Double(currentWords.count))
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // メインカード
                VStack(spacing: 25) {
                    // 韓国語
                    Text(currentWord.korean)
                        .font(.system(size: 48, weight: .medium, design: .default))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // 発音ボタン
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showPronunciation.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showPronunciation ? "speaker.slash" : "speaker.wave.2")
                            Text(showPronunciation ? "発音を隠す" : "発音を表示")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(20)
                    }
                    
                    // 発音表示
                    if showPronunciation {
                        Text(currentWord.pronunciation)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .transition(.opacity.combined(with: .scale))
                    }
                    
                    // 日本語訳ボタン
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showJapanese.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showJapanese ? "eye.slash" : "eye")
                            Text(showJapanese ? "意味を隠す" : "意味を表示")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.green)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(20)
                    }
                    
                    // 日本語訳表示
                    if showJapanese {
                        Text(currentWord.japanese)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(15)
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // ナビゲーションボタン
                HStack(spacing: 20) {
                    Button(action: previousWord) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("前へ")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(currentWordIndex > 0 ? Color.blue : Color.gray)
                        .cornerRadius(25)
                    }
                    .disabled(currentWordIndex <= 0)
                    
                    Button(action: nextWord) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.right")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(currentWordIndex < currentWords.count - 1 ? Color.blue : Color.gray)
                        .cornerRadius(25)
                    }
                    .disabled(currentWordIndex >= currentWords.count - 1)
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("単語学習")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func previousWord() {
        if currentWordIndex > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentWordIndex -= 1
                showJapanese = false
                showPronunciation = false
            }
        }
    }
    
    private func nextWord() {
        if currentWordIndex < currentWords.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentWordIndex += 1
                showJapanese = false
                showPronunciation = false
            }
        }
    }
}

#Preview {
    WordStudyView()
}
