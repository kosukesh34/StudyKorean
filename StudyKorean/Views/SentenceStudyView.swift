import SwiftUI

struct SentenceStudyView: View {
    @StateObject private var speechManager = SpeechManager()
    @State private var sentences = KoreanSentenceData.sentences
    @State private var currentSentenceIndex = 0
    @State private var showPronunciation = false
    @State private var showJapanese = false
    @State private var showEnglish = false
    @State private var searchText = ""
    @State private var selectedCategory: KoreanSentence.SentenceCategory?
    @State private var selectedDifficulty: KoreanSentence.DifficultyLevel?
    @State private var showFilters = false
    
    private var filteredSentences: [KoreanSentence] {
        var filtered = sentences
        
        // 検索フィルタ
        if !searchText.isEmpty {
            filtered = filtered.filter { sentence in
                sentence.korean.lowercased().contains(searchText.lowercased()) ||
                sentence.japanese.lowercased().contains(searchText.lowercased()) ||
                sentence.english.lowercased().contains(searchText.lowercased()) ||
                sentence.tags.contains { $0.lowercased().contains(searchText.lowercased()) }
            }
        }
        
        // カテゴリフィルタ
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        // 難易度フィルタ
        if let difficulty = selectedDifficulty {
            filtered = filtered.filter { $0.difficulty == difficulty }
        }
        
        return filtered
    }
    
    private var currentSentence: KoreanSentence {
        guard !filteredSentences.isEmpty else {
            return KoreanSentence(
                korean: "문장이 없습니다",
                pronunciation: "munjangi eopseumnida",
                japanese: "文章がありません",
                english: "No sentences available",
                category: .daily,
                difficulty: .beginner,
                tags: []
            )
        }
        return filteredSentences[currentSentenceIndex]
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 検索バー
                    SearchBar(text: $searchText, placeholder: "文章を検索...")
                        .padding(.horizontal, 20)
                    
                    // フィルターボタン
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showFilters.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                Text("フィルター")
                            }
                            .foregroundColor(.blue)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(20)
                        }
                        
                        Spacer()
                        
                        // 進捗表示
                        Text("\(currentSentenceIndex + 1) / \(filteredSentences.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    
                    // フィルター表示
                    if showFilters {
                        FilterView(
                            selectedCategory: $selectedCategory,
                            selectedDifficulty: $selectedDifficulty
                        )
                        .padding(.horizontal, 20)
                    }
                    
                    if filteredSentences.isEmpty {
                        EmptyStateView()
                            .frame(minHeight: 400)
                    } else {
                        // 文章カード
                        SentenceCardView(
                            sentence: currentSentence,
                            showPronunciation: $showPronunciation,
                            showJapanese: $showJapanese,
                            showEnglish: $showEnglish,
                            speechManager: speechManager
                        )
                        .padding(.horizontal, 20)
                        
                        // ナビゲーションボタン
                        NavigationButtonsView(
                            currentIndex: $currentSentenceIndex,
                            totalCount: filteredSentences.count,
                            onPrevious: previousSentence,
                            onNext: nextSentence
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle("長文学習")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SentenceQuizView()) {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onChange(of: filteredSentences) { _ in
                if currentSentenceIndex >= filteredSentences.count {
                    currentSentenceIndex = 0
                }
            }
        }
    }
    
    private func previousSentence() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if currentSentenceIndex > 0 {
                currentSentenceIndex -= 1
            } else {
                currentSentenceIndex = filteredSentences.count - 1
            }
        }
    }
    
    private func nextSentence() {
        withAnimation(.easeInOut(duration: 0.3)) {
            if currentSentenceIndex < filteredSentences.count - 1 {
                currentSentenceIndex += 1
            } else {
                currentSentenceIndex = 0
            }
        }
    }
}

// 文章カードビュー
struct SentenceCardView: View {
    let sentence: KoreanSentence
    @Binding var showPronunciation: Bool
    @Binding var showJapanese: Bool
    @Binding var showEnglish: Bool
    @ObservedObject var speechManager: SpeechManager
    
    var body: some View {
        VStack(spacing: 25) {
            // カテゴリと難易度バッジ
            HStack {
                Text(sentence.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(sentence.category.color))
                    .cornerRadius(12)
                
                Text(sentence.difficulty.rawValue)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(sentence.difficulty.color))
                    .cornerRadius(12)
                
                Spacer()
            }
            
            // 韓国語文章
            HStack {
                Text(sentence.korean)
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
                // 音声再生ボタン
                Button(action: {
                    speechManager.speakKorean(sentence.korean)
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
                .foregroundColor(.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(20)
            }
            
            // 発音表示
            if showPronunciation {
                Text(sentence.pronunciation)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(15)
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
                    Text(showJapanese ? "日本語を隠す" : "日本語を表示")
                }
                .foregroundColor(.green)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(20)
            }
            
            // 日本語訳表示
            if showJapanese {
                HStack {
                    Text(sentence.japanese)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    
                    // 日本語音声再生ボタン
                    Button(action: {
                        speechManager.speakJapanese(sentence.japanese)
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
            
            // 英語訳ボタン
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    showEnglish.toggle()
                }
            }) {
                HStack {
                    Image(systemName: showEnglish ? "eye.slash" : "eye")
                    Text(showEnglish ? "英語を隠す" : "英語を表示")
                }
                .foregroundColor(.orange)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(20)
            }
            
            // 英語訳表示
            if showEnglish {
                Text(sentence.english)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(15)
                    .transition(.opacity.combined(with: .scale))
            }
            
            // タグ表示
            if !sentence.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(sentence.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .padding(25)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

// フィルタービュー
struct FilterView: View {
    @Binding var selectedCategory: KoreanSentence.SentenceCategory?
    @Binding var selectedDifficulty: KoreanSentence.DifficultyLevel?
    
    var body: some View {
        VStack(spacing: 15) {
            // カテゴリフィルター
            VStack(alignment: .leading, spacing: 10) {
                Text("カテゴリ")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterChip(
                            title: "すべて",
                            isSelected: selectedCategory == nil,
                            color: .gray
                        ) {
                            selectedCategory = nil
                        }
                        
                        ForEach(KoreanSentence.SentenceCategory.allCases, id: \.self) { category in
                            FilterChip(
                                title: category.rawValue,
                                isSelected: selectedCategory == category,
                                color: Color(category.color)
                            ) {
                                selectedCategory = selectedCategory == category ? nil : category
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            // 難易度フィルター
            VStack(alignment: .leading, spacing: 10) {
                Text("難易度")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack(spacing: 10) {
                    FilterChip(
                        title: "すべて",
                        isSelected: selectedDifficulty == nil,
                        color: .gray
                    ) {
                        selectedDifficulty = nil
                    }
                    
                    ForEach(KoreanSentence.DifficultyLevel.allCases, id: \.self) { difficulty in
                        FilterChip(
                            title: difficulty.rawValue,
                            isSelected: selectedDifficulty == difficulty,
                            color: Color(difficulty.color)
                        ) {
                            selectedDifficulty = selectedDifficulty == difficulty ? nil : difficulty
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(20)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// フィルターチップ
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? color : Color(.systemGray5))
                .cornerRadius(12)
        }
    }
}

// 検索バー
struct SearchBar: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// 空の状態ビュー
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "text.bubble")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("文章が見つかりません")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("検索条件を変更してください")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(40)
    }
}

// ナビゲーションボタンビュー
struct NavigationButtonsView: View {
    @Binding var currentIndex: Int
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
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(25)
            }
            
            Spacer()
            
            Button(action: onNext) {
                HStack {
                    Text("次へ")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(25)
            }
        }
    }
}
