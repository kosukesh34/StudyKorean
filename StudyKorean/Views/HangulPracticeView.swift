//
//  HangulPracticeView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct HangulPracticeView: View {
    @StateObject private var speechManager = SpeechManager()
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
            VStack(spacing: 30) {
                // タイプ選択
                Picker("文字種類", selection: $selectedType) {
                    ForEach(KoreanCharacter.CharacterType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: selectedType) { _ in
                    currentCharacterIndex = 0
                    showPronunciation = false
                }
                
                // 進行状況
                VStack {
                    Text("\(currentCharacterIndex + 1) / \(currentCharacters.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: Double(currentCharacterIndex + 1), total: Double(currentCharacters.count))
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // メインカード
                VStack(spacing: 20) {
                    // ハングル文字
                    HStack {
                        Text(currentCharacter.korean)
                            .font(.system(size: 120, weight: .medium, design: .default))
                            .foregroundColor(.primary)
                        
                        // 音声再生ボタン
                        Button(action: {
                            speechManager.speakKorean(currentCharacter.korean)
                        }) {
                            Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                                .font(.title)
                                .foregroundColor(.blue)
                                .scaleEffect(speechManager.isSpeaking ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.3), value: speechManager.isSpeaking)
                        }
                        .disabled(!speechManager.isAvailable)
                    }
                    
                    // 発音表示ボタン
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
                        Text(currentCharacter.pronunciation)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(40)
                .background(Color(.systemBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // ナビゲーションボタン
                HStack(spacing: 20) {
                    Button(action: previousCharacter) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("前へ")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(currentCharacterIndex > 0 ? Color.blue : Color.gray)
                        .cornerRadius(25)
                    }
                    .disabled(currentCharacterIndex <= 0)
                    
                    Button(action: nextCharacter) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.right")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(currentCharacterIndex < currentCharacters.count - 1 ? Color.blue : Color.gray)
                        .cornerRadius(25)
                    }
                    .disabled(currentCharacterIndex >= currentCharacters.count - 1)
                }
                .padding(.bottom, 30)
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

#Preview {
    HangulPracticeView()
}
