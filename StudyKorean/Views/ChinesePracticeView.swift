//
//  ChinesePracticeView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct ChinesePracticeView: View {
    @State private var selectedCategory: ChineseCharacter.CharacterCategory = .basic
    @State private var showPinyin = false
    @State private var showJapanese = false
    
    private var currentCharacters: [ChineseCharacter] {
        ChineseCharacterData.characters(for: selectedCategory)
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
                            ForEach(ChineseCharacter.CharacterCategory.allCases, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                    showPinyin = false
                                    showJapanese = false
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
                            showPinyin.toggle()
                        }
                    }) {
                        HStack {
                            Image(systemName: showPinyin ? "textformat.subscript" : "textformat.superscript")
                            Text(showPinyin ? "拼音を隠す" : "拼音を表示")
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.orange)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.orange.opacity(0.1))
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
                
                // 漢字一覧表示（全文表示）
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(currentCharacters) { character in
                            CharacterCard(
                                character: character,
                                showPinyin: showPinyin,
                                showJapanese: showJapanese
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("漢字練習")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct CharacterCard: View {
    let character: ChineseCharacter
    let showPinyin: Bool
    let showJapanese: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // 漢字
            Text(character.character)
                .font(.system(size: 48, weight: .medium, design: .default))
                .foregroundColor(.primary)
            
            // 拼音
            if showPinyin {
                Text(character.pinyin)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.orange)
                    .transition(.opacity.combined(with: .scale))
            }
            
            // 日本語意味
            if showJapanese {
                Text(character.japanese)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .frame(height: showPinyin && showJapanese ? 140 : showPinyin || showJapanese ? 120 : 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ChinesePracticeView()
}
