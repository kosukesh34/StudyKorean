//
//  AdvancedWordStudyView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct AdvancedWordStudyView: View {
    @StateObject private var progressManager = StudyProgressManager()
    @StateObject private var speechManager = SpeechManager()
    @State private var selectedCategory: KoreanWord.WordCategory = .greetings
    @State private var selectedMasteryLevel: WordMastery.MasteryLevel? = nil
    @State private var currentWordIndex = 0
    @State private var showJapanese = false
    @State private var showPronunciation = false
    @State private var searchText = ""
    @State private var showingStudyMode = false
    
    private var filteredWords: [KoreanWord] {
        var words = KoreanWordData.words
        
        // カテゴリフィルター
        if selectedCategory != .greetings {
            words = words.filter { $0.category == selectedCategory }
        }
        
        // 習熟度フィルター
        if let masteryLevel = selectedMasteryLevel {
            words = words.filter { word in
                guard let mastery = progressManager.wordMasteries[word.id] else { return false }
                return mastery.masteryLevel == masteryLevel
            }
        }
        
        // 検索フィルター
        if !searchText.isEmpty {
            words = words.filter { word in
                word.korean.localizedCaseInsensitiveContains(searchText) ||
                word.pronunciation.localizedCaseInsensitiveContains(searchText) ||
                word.japanese.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return words
    }
    
    private var currentWord: KoreanWord {
        guard currentWordIndex < filteredWords.count else {
            return filteredWords.first ?? KoreanWordData.words.first!
        }
        return filteredWords[currentWordIndex]
    }
    
    private var currentMastery: WordMastery? {
        return progressManager.wordMasteries[currentWord.id]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 検索バー
                    SearchBar(text: $searchText, placeholder: "単語を検索...")
                        .padding(.horizontal)
                    
                    // フィルター
                    WordFilterView(
                        selectedCategory: $selectedCategory,
                        selectedMasteryLevel: $selectedMasteryLevel
                    )
                    .padding(.horizontal)
                    
                    // 統計情報
                    StatisticsView(statistics: progressManager.getStudyStatistics())
                        .padding(.horizontal)
                    
                    if filteredWords.isEmpty {
                        WordEmptyStateView()
                            .frame(minHeight: 400)
                    } else {
                        // メインコンテンツ
                        VStack(spacing: 20) {
                            // 進行状況
                            VStack {
                                Text("\(currentWordIndex + 1) / \(filteredWords.count)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                ProgressView(value: Double(currentWordIndex + 1), total: Double(filteredWords.count))
                                    .padding(.horizontal, 20)
                            }
                            
                                                    // 単語カード
                        WordCardView(
                            word: currentWord,
                            mastery: currentMastery,
                            showPronunciation: $showPronunciation,
                            showJapanese: $showJapanese,
                            speechManager: speechManager
                        )
                            
                            // ナビゲーションボタン
                            WordNavigationButtonsView(
                                currentIndex: currentWordIndex,
                                totalCount: filteredWords.count,
                                onPrevious: previousWord,
                                onNext: nextWord
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle("単語学習")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("復習モード") {
                        showingStudyMode = true
                    }
                    .disabled(progressManager.getWordsForReview().isEmpty)
                }
            }
            .sheet(isPresented: $showingStudyMode) {
                ReviewModeView(progressManager: progressManager)
            }
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
        if currentWordIndex < filteredWords.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentWordIndex += 1
                showJapanese = false
                showPronunciation = false
            }
        }
    }
}



struct WordFilterView: View {
    @Binding var selectedCategory: KoreanWord.WordCategory
    @Binding var selectedMasteryLevel: WordMastery.MasteryLevel?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // カテゴリフィルター
                ForEach(KoreanWord.WordCategory.allCases, id: \.self) { category in
                    WordFilterChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category,
                        color: .blue,
                        action: { selectedCategory = category }
                    )
                }
                
                Divider()
                    .frame(height: 20)
                
                // 習熟度フィルター
                ForEach(WordMastery.MasteryLevel.allCases, id: \.self) { level in
                    WordFilterChip(
                        title: level.rawValue,
                        isSelected: selectedMasteryLevel == level,
                        color: Color(level.color),
                        action: { 
                            selectedMasteryLevel = selectedMasteryLevel == level ? nil : level
                        }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WordFilterChip: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .white : color)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? color : color.opacity(0.1))
                .cornerRadius(15)
        }
    }
}

struct StatisticsView: View {
    let statistics: StudyStatistics
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("学習進捗")
                    .font(.headline)
                Spacer()
                Text("\(Int(statistics.masteryPercentage))% 習得")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            
            ProgressView(value: statistics.progressPercentage, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
            
            HStack(spacing: 20) {
                StatItem(title: "習得済み", value: "\(statistics.masteredWords)", color: .green)
                StatItem(title: "学習中", value: "\(statistics.learningWords)", color: .orange)
                StatItem(title: "復習必要", value: "\(statistics.reviewWords)", color: .red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct WordCardView: View {
    let word: KoreanWord
    let mastery: WordMastery?
    @Binding var showPronunciation: Bool
    @Binding var showJapanese: Bool
    @ObservedObject var speechManager: SpeechManager
    
    var body: some View {
        VStack(spacing: 25) {
            // 習熟度バッジ
            if let mastery = mastery {
                HStack {
                    Text(mastery.masteryLevel.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(mastery.masteryLevel.color).opacity(0.2))
                        .foregroundColor(Color(mastery.masteryLevel.color))
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    Text("正答率: \(Int(mastery.accuracy * 100))%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // 韓国語
            HStack {
                Text(word.korean)
                    .font(.system(size: 48, weight: .medium, design: .default))
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
            
            // 発音ボタン
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showPronunciation.toggle()
                }
            }) {
                HStack {
                    Image(systemName: showPronunciation ? "eye.slash" : "eye")
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
                Text(word.pronunciation)
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
                HStack {
                    Text(word.japanese)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // 日本語音声再生ボタン
                    Button(action: {
                        speechManager.speakJapanese(word.japanese)
                    }) {
                        Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                            .font(.title3)
                            .foregroundColor(.green)
                            .scaleEffect(speechManager.isSpeaking ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: speechManager.isSpeaking)
                    }
                    .disabled(!speechManager.isAvailable)
                }
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
    }
}

struct WordNavigationButtonsView: View {
    let currentIndex: Int
    let totalCount: Int
    let onPrevious: () -> Void
    let onNext: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onPrevious) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("前へ")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(currentIndex > 0 ? Color.blue : Color.gray)
                .cornerRadius(25)
            }
            .disabled(currentIndex <= 0)
            
            Button(action: onNext) {
                HStack {
                    Text("次へ")
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(currentIndex < totalCount - 1 ? Color.blue : Color.gray)
                .cornerRadius(25)
            }
            .disabled(currentIndex >= totalCount - 1)
        }
        .padding(.bottom, 30)
    }
}

struct WordEmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("該当する単語が見つかりません")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("検索条件を変更してください")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AdvancedWordStudyView()
}
