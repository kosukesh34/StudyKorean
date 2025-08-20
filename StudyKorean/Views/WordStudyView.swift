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
                
                // 表示オプション
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showPronunciation.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showPronunciation ? "speaker.slash" : "speaker.wave.2")
                            Text(showPronunciation ? "発音を隠す" : "発音を表示")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(15)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showJapanese.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showJapanese ? "eye.slash" : "eye")
                            Text(showJapanese ? "意味を隠す" : "意味を表示")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.green)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                
                // 単語一覧表示（全文表示）
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(currentWords) { word in
                            WordCard(
                                word: word,
                                showPronunciation: showPronunciation,
                                showJapanese: showJapanese
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
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

struct WordCard: View {
    let word: KoreanWord
    let showPronunciation: Bool
    let showJapanese: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // 韓国語
            Text(word.korean)
                .font(.system(size: 24, weight: .medium, design: .default))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            // 発音
            if showPronunciation {
                Text(word.pronunciation)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .transition(.opacity.combined(with: .scale))
            }
            
            // 日本語意味
            if showJapanese {
                Text(word.japanese)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(height: showPronunciation && showJapanese ? 140 : showPronunciation || showJapanese ? 120 : 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    WordStudyView()
}
