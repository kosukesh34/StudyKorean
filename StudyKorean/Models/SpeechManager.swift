//
//  SpeechManager.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import Foundation
import AVFoundation
import Speech

class SpeechManager: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    private var speechDelegate: SpeechDelegate?
    @Published var isSpeaking = false
    @Published var isAvailable = false
    
    init() {
        setupAudioSession()
        checkSpeechAvailability()
    }
    
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)
            print("音声セッション設定完了")
        } catch {
            print("音声セッション設定エラー: \(error)")
        }
    }
    
    private func checkSpeechAvailability() {
        // 音声合成が利用可能かチェック
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let koreanVoices = voices.filter { $0.language.starts(with: "ko") }
        let japaneseVoices = voices.filter { $0.language.starts(with: "ja") }
        
        // 韓国語または日本語音声が利用可能であればOK
        isAvailable = !koreanVoices.isEmpty || !japaneseVoices.isEmpty
        
        print("利用可能な音声:")
        print("韓国語音声: \(koreanVoices.count)個")
        print("日本語音声: \(japaneseVoices.count)個")
        print("音声利用可能: \(isAvailable)")
    }
    
    func speakKorean(_ text: String) {
        print("韓国語音声再生開始: \(text)")
        
        // 既に再生中の場合は停止
        if isSpeaking {
            stopSpeaking()
        }
        
        let utterance = AVSpeechUtterance(string: text)
        
        // 韓国語音声を設定（よりリアルな音声を優先）
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let koreanVoices = voices.filter { $0.language.starts(with: "ko") }
        
        print("利用可能な韓国語音声: \(koreanVoices.count)個")
        
        // よりリアルな音声を優先選択
        if let enhancedVoice = koreanVoices.first(where: { $0.quality == .enhanced }) {
            utterance.voice = enhancedVoice
            print("高品質音声を使用: \(enhancedVoice.name)")
        } else if let femaleVoice = koreanVoices.first(where: { $0.gender == .female }) {
            utterance.voice = femaleVoice
            print("女性音声を使用: \(femaleVoice.name)")
        } else if let koreanVoice = koreanVoices.first {
            utterance.voice = koreanVoice
            print("デフォルト韓国語音声を使用: \(koreanVoice.name)")
        } else {
            // 韓国語音声が見つからない場合はシステムデフォルト音声を使用
            utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
            print("システムデフォルト音声を使用")
        }
        
        // よりリアルな音声設定
        utterance.rate = 0.4 // 自然な速度
        utterance.pitchMultiplier = 1.0 // 自然なピッチ
        utterance.volume = 1.0 // 最大音量
        utterance.preUtteranceDelay = 0.0 // 遅延なし
        
        // 再生開始
        synthesizer.speak(utterance)
        isSpeaking = true
        print("音声再生開始")
        
        // 再生完了時の処理
        speechDelegate = SpeechDelegate { [weak self] in
            DispatchQueue.main.async {
                self?.isSpeaking = false
                print("音声再生完了")
            }
        }
        synthesizer.delegate = speechDelegate
    }
    
    func stopSpeaking() {
        print("音声停止")
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        isSpeaking = false
        speechDelegate = nil
    }
    
    func speakJapanese(_ text: String) {
        print("日本語音声再生開始: \(text)")
        
        // 既に再生中の場合は停止
        if isSpeaking {
            stopSpeaking()
        }
        
        let utterance = AVSpeechUtterance(string: text)
        
        // 日本語音声を設定（よりリアルな音声を優先）
        let voices = AVSpeechSynthesisVoice.speechVoices()
        let japaneseVoices = voices.filter { $0.language.starts(with: "ja") }
        
        print("利用可能な日本語音声: \(japaneseVoices.count)個")
        
        // よりリアルな音声を優先選択
        if let enhancedVoice = japaneseVoices.first(where: { $0.quality == .enhanced }) {
            utterance.voice = enhancedVoice
            print("高品質音声を使用: \(enhancedVoice.name)")
        } else if let femaleVoice = japaneseVoices.first(where: { $0.gender == .female }) {
            utterance.voice = femaleVoice
            print("女性音声を使用: \(femaleVoice.name)")
        } else if let japaneseVoice = japaneseVoices.first {
            utterance.voice = japaneseVoice
            print("デフォルト日本語音声を使用: \(japaneseVoice.name)")
        } else {
            // 日本語音声が見つからない場合はシステムデフォルト音声を使用
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            print("システムデフォルト音声を使用")
        }
        
        // よりリアルな音声設定
        utterance.rate = 0.4 // 自然な速度
        utterance.pitchMultiplier = 1.0 // 自然なピッチ
        utterance.volume = 1.0 // 最大音量
        utterance.preUtteranceDelay = 0.0 // 遅延なし
        
        // 再生開始
        synthesizer.speak(utterance)
        isSpeaking = true
        print("音声再生開始")
        
        // 再生完了時の処理
        speechDelegate = SpeechDelegate { [weak self] in
            DispatchQueue.main.async {
                self?.isSpeaking = false
                print("音声再生完了")
            }
        }
        synthesizer.delegate = speechDelegate
    }
}

// AVSpeechSynthesizerDelegateの実装
class SpeechDelegate: NSObject, AVSpeechSynthesizerDelegate {
    private let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
        super.init()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("音声再生完了: \(utterance.speechString)")
        completion()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("音声再生キャンセル: \(utterance.speechString)")
        completion()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("音声再生開始: \(utterance.speechString)")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        // 音声の進行状況を追跡（必要に応じて）
    }
}
