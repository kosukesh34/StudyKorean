//
//  StudyProgress.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import Foundation

struct StudyProgress: Identifiable, Codable {
    let id = UUID()
    let wordId: UUID
    let studyDate: Date
    let isCorrect: Bool
    let studyType: StudyType
    
    enum StudyType: String, CaseIterable, Codable {
        case quiz = "クイズ"
        case review = "復習"
        case practice = "練習"
    }
}

struct WordMastery: Identifiable, Codable {
    let id = UUID()
    let wordId: UUID
    var correctCount: Int
    var incorrectCount: Int
    var lastStudied: Date?
    var masteryLevel: MasteryLevel
    
    enum MasteryLevel: String, CaseIterable, Codable {
        case new = "未学習"
        case learning = "学習中"
        case mastered = "習得済み"
        case review = "復習必要"
        
        var color: String {
            switch self {
            case .new: return "gray"
            case .learning: return "orange"
            case .mastered: return "green"
            case .review: return "red"
            }
        }
    }
    
    var totalAttempts: Int {
        return correctCount + incorrectCount
    }
    
    var accuracy: Double {
        guard totalAttempts > 0 else { return 0.0 }
        return Double(correctCount) / Double(totalAttempts)
    }
    
    var shouldReview: Bool {
        return masteryLevel == .review || 
               (masteryLevel == .learning && accuracy < 0.7) ||
               (lastStudied != nil && Date().timeIntervalSince(lastStudied!) > 7 * 24 * 60 * 60) // 1週間以上
    }
}

class StudyProgressManager: ObservableObject {
    @Published var wordMasteries: [UUID: WordMastery] = [:]
    @Published var studyHistory: [StudyProgress] = []
    
    private let userDefaults = UserDefaults.standard
    private let wordMasteriesKey = "WordMasteries"
    private let studyHistoryKey = "StudyHistory"
    
    init() {
        loadData()
        initializeWordMasteries()
    }
    
    private func loadData() {
        if let data = userDefaults.data(forKey: wordMasteriesKey),
           let masteries = try? JSONDecoder().decode([UUID: WordMastery].self, from: data) {
            wordMasteries = masteries
        }
        
        if let data = userDefaults.data(forKey: studyHistoryKey),
           let history = try? JSONDecoder().decode([StudyProgress].self, from: data) {
            studyHistory = history
        }
    }
    
    private func saveData() {
        if let data = try? JSONEncoder().encode(wordMasteries) {
            userDefaults.set(data, forKey: wordMasteriesKey)
        }
        
        if let data = try? JSONEncoder().encode(studyHistory) {
            userDefaults.set(data, forKey: studyHistoryKey)
        }
    }
    
    private func initializeWordMasteries() {
        for word in KoreanWordData.words {
            if wordMasteries[word.id] == nil {
                wordMasteries[word.id] = WordMastery(
                    wordId: word.id,
                    correctCount: 0,
                    incorrectCount: 0,
                    lastStudied: nil,
                    masteryLevel: .new
                )
            }
        }
        saveData()
    }
    
    func recordStudyResult(wordId: UUID, isCorrect: Bool, studyType: StudyProgress.StudyType) {
        let progress = StudyProgress(
            wordId: wordId,
            studyDate: Date(),
            isCorrect: isCorrect,
            studyType: studyType
        )
        
        studyHistory.append(progress)
        
        // Update mastery
        var mastery = wordMasteries[wordId] ?? WordMastery(
            wordId: wordId,
            correctCount: 0,
            incorrectCount: 0,
            lastStudied: nil,
            masteryLevel: .new
        )
        
        if isCorrect {
            mastery.correctCount += 1
        } else {
            mastery.incorrectCount += 1
        }
        
        mastery.lastStudied = Date()
        mastery.masteryLevel = calculateMasteryLevel(mastery)
        
        wordMasteries[wordId] = mastery
        saveData()
    }
    
    private func calculateMasteryLevel(_ mastery: WordMastery) -> WordMastery.MasteryLevel {
        let total = mastery.totalAttempts
        let accuracy = mastery.accuracy
        
        if total < 3 {
            return .new
        } else if accuracy >= 0.8 && total >= 5 {
            return .mastered
        } else if accuracy < 0.5 {
            return .review
        } else {
            return .learning
        }
    }
    
    func getWordsForReview() -> [KoreanWord] {
        return KoreanWordData.words.filter { word in
            guard let mastery = wordMasteries[word.id] else { return false }
            return mastery.shouldReview
        }
    }
    
    func getWordsByMasteryLevel(_ level: WordMastery.MasteryLevel) -> [KoreanWord] {
        return KoreanWordData.words.filter { word in
            guard let mastery = wordMasteries[word.id] else { return false }
            return mastery.masteryLevel == level
        }
    }
    
    func getStudyStatistics() -> StudyStatistics {
        let totalWords = KoreanWordData.words.count
        let masteredWords = getWordsByMasteryLevel(.mastered).count
        let learningWords = getWordsByMasteryLevel(.learning).count
        let reviewWords = getWordsByMasteryLevel(.review).count
        let newWords = getWordsByMasteryLevel(.new).count
        
        let totalAttempts = studyHistory.count
        let correctAttempts = studyHistory.filter { $0.isCorrect }.count
        let accuracy = totalAttempts > 0 ? Double(correctAttempts) / Double(totalAttempts) : 0.0
        
        return StudyStatistics(
            totalWords: totalWords,
            masteredWords: masteredWords,
            learningWords: learningWords,
            reviewWords: reviewWords,
            newWords: newWords,
            totalAttempts: totalAttempts,
            correctAttempts: correctAttempts,
            accuracy: accuracy
        )
    }
}

struct StudyStatistics {
    let totalWords: Int
    let masteredWords: Int
    let learningWords: Int
    let reviewWords: Int
    let newWords: Int
    let totalAttempts: Int
    let correctAttempts: Int
    let accuracy: Double
    
    var masteryPercentage: Double {
        guard totalWords > 0 else { return 0.0 }
        return Double(masteredWords) / Double(totalWords) * 100.0
    }
    
    var progressPercentage: Double {
        guard totalWords > 0 else { return 0.0 }
        return Double(masteredWords + learningWords) / Double(totalWords) * 100.0
    }
}
