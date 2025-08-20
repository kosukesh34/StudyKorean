//
//  HangulPracticeView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct HangulPracticeView: View {
    @State private var currentCharacterIndex = 0
    @State private var selectedType: KoreanCharacter.CharacterType = .consonant
    @State private var showPronunciation = false
    
    private var currentCharacters: [KoreanCharacter] {
        switch selectedType {
        case .consonant:
            return KoreanCharacterData.consonants
        case .vowel:
            return KoreanCharacterData.vowels
        }
    }
    
    private var currentCharacter: KoreanCharacter {
        guard currentCharacterIndex < currentCharacters.count else {
            return currentCharacters.first!
        }
        return currentCharacters[currentCharacterIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // タイプ選択
                Picker("文字種類", selection: $selectedType) {
                    ForEach(KoreanCharacter.CharacterType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: selectedType) { _ in
                    showPronunciation = false
                }
                
                // 表示オプション
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showPronunciation.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showPronunciation ? "eye.slash" : "eye")
                            Text(showPronunciation ? "発音を隠す" : "発音を表示")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                
                // ハングル一覧表示（全文表示）
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(currentCharacters) { character in
                            HangulCard(
                                character: character,
                                showPronunciation: showPronunciation
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("ハングル練習")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func previousCharacter() {
        if currentCharacterIndex > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentCharacterIndex -= 1
                showPronunciation = false
            }
        }
    }
    
    private func nextCharacter() {
        if currentCharacterIndex < currentCharacters.count - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentCharacterIndex += 1
                showPronunciation = false
            }
        }
    }
}

struct HangulCard: View {
    let character: KoreanCharacter
    let showPronunciation: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // ハングル文字
            Text(character.korean)
                .font(.system(size: 48, weight: .medium, design: .default))
                .foregroundColor(.primary)
            
            // 発音
            if showPronunciation {
                Text(character.pronunciation)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(height: showPronunciation ? 120 : 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HangulPracticeView()
}
