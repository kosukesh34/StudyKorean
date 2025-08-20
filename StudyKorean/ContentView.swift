//
//  ContentView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
            
            HangulPracticeView()
                .tabItem {
                    Image(systemName: "textformat.abc")
                    Text("ハングル練習")
                }
            
            AdvancedWordStudyView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("単語学習")
                }
            
                                    QuizView()
                            .tabItem {
                                Image(systemName: "questionmark.circle.fill")
                                Text("クイズ")
                            }
                        
                        SentenceStudyView()
                            .tabItem {
                                Image(systemName: "text.bubble.fill")
                                Text("長文学習")
                            }
        }
        .accentColor(.blue)
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // ヘッダー
                    VStack(spacing: 10) {
                        Text("韓国語学習アプリ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("한국어 공부하자!")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 20)
                    
                    // 機能カード
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        FeatureCard(
                            icon: "textformat.abc",
                            title: "ハングル練習",
                            description: "基本文字を\n一つずつ学習",
                            color: .purple
                        )
                        
                        FeatureCard(
                            icon: "book.fill",
                            title: "単語学習",
                            description: "日常的な韓国語\n単語を習得",
                            color: .green
                        )
                        
                        FeatureCard(
                            icon: "questionmark.circle.fill",
                            title: "クイズ",
                            description: "学習した内容を\nテストで確認",
                            color: .orange
                        )
                        
                        FeatureCard(
                            icon: "chart.bar.fill",
                            title: "学習記録",
                            description: "進捗を確認\n（今後追加予定）",
                            color: .red
                        )
                    }
                    .padding(.horizontal, 20)
                    
                    // 統計情報
                    VStack(spacing: 15) {
                        Text("学習コンテンツ")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 20) {
                            StatCard(
                                title: "ハングル文字",
                                value: "\(KoreanCharacterData.allCharacters.count)",
                                subtitle: "文字"
                            )
                            
                            StatCard(
                                title: "韓国語単語",
                                value: "\(KoreanWordData.words.count)",
                                subtitle: "単語"
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 50)
                }
            }
            .navigationTitle("韓国語学習")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    ContentView()
}
