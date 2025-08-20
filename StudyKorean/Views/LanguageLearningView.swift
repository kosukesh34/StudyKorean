//
//  LanguageLearningView.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import SwiftUI

struct LanguageLearningView: View {
    @State private var selectedLanguage: Language = .korean
    
    enum Language: String, CaseIterable {
        case korean = "韓国語"
        case chinese = "中国語"
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 言語選択
                Picker("言語", selection: $selectedLanguage) {
                    ForEach(Language.allCases, id: \.self) { language in
                        Text(language.rawValue).tag(language)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 選択された言語に応じてビューを表示
                Group {
                    switch selectedLanguage {
                    case .korean:
                        HangulPracticeView()
                    case .chinese:
                        ChinesePracticeView()
                    }
                }
            }
            .navigationTitle("文字練習")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    LanguageLearningView()
}
