//
//  KoreanCharacter.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import Foundation

struct KoreanCharacter: Identifiable, Codable {
    let id = UUID()
    let korean: String
    let pronunciation: String
    let type: CharacterType
    
    enum CharacterType: String, CaseIterable, Codable {
        case consonant = "子音"
        case vowel = "母音"
    }
}

// ハングル文字データ
class KoreanCharacterData {
    static let consonants: [KoreanCharacter] = [
        KoreanCharacter(korean: "ㄱ", pronunciation: "ギョク (g/k)", type: .consonant),
        KoreanCharacter(korean: "ㄴ", pronunciation: "ニウン (n)", type: .consonant),
        KoreanCharacter(korean: "ㄷ", pronunciation: "ディグッ (d/t)", type: .consonant),
        KoreanCharacter(korean: "ㄹ", pronunciation: "リウル (r/l)", type: .consonant),
        KoreanCharacter(korean: "ㅁ", pronunciation: "ミウム (m)", type: .consonant),
        KoreanCharacter(korean: "ㅂ", pronunciation: "ビウプ (b/p)", type: .consonant),
        KoreanCharacter(korean: "ㅅ", pronunciation: "シオッ (s)", type: .consonant),
        KoreanCharacter(korean: "ㅇ", pronunciation: "イウン (無音/ng)", type: .consonant),
        KoreanCharacter(korean: "ㅈ", pronunciation: "チウッ (j)", type: .consonant),
        KoreanCharacter(korean: "ㅊ", pronunciation: "チウッ (ch)", type: .consonant),
        KoreanCharacter(korean: "ㅋ", pronunciation: "キウク (k)", type: .consonant),
        KoreanCharacter(korean: "ㅌ", pronunciation: "ティウッ (t)", type: .consonant),
        KoreanCharacter(korean: "ㅍ", pronunciation: "ピウプ (p)", type: .consonant),
        KoreanCharacter(korean: "ㅎ", pronunciation: "ヒウッ (h)", type: .consonant),
        // 激音・濃音
        KoreanCharacter(korean: "ㄲ", pronunciation: "サンギョク (強いg)", type: .consonant),
        KoreanCharacter(korean: "ㄸ", pronunciation: "サンディグッ (強いd)", type: .consonant),
        KoreanCharacter(korean: "ㅃ", pronunciation: "サンビウプ (強いb)", type: .consonant),
        KoreanCharacter(korean: "ㅆ", pronunciation: "サンシオッ (強いs)", type: .consonant),
        KoreanCharacter(korean: "ㅉ", pronunciation: "サンチウッ (強いj)", type: .consonant)
    ]
    
    static let vowels: [KoreanCharacter] = [
        KoreanCharacter(korean: "ㅏ", pronunciation: "ア (a)", type: .vowel),
        KoreanCharacter(korean: "ㅑ", pronunciation: "ヤ (ya)", type: .vowel),
        KoreanCharacter(korean: "ㅓ", pronunciation: "オ (eo)", type: .vowel),
        KoreanCharacter(korean: "ㅕ", pronunciation: "ヨ (yeo)", type: .vowel),
        KoreanCharacter(korean: "ㅗ", pronunciation: "オ (o)", type: .vowel),
        KoreanCharacter(korean: "ㅛ", pronunciation: "ヨ (yo)", type: .vowel),
        KoreanCharacter(korean: "ㅜ", pronunciation: "ウ (u)", type: .vowel),
        KoreanCharacter(korean: "ㅠ", pronunciation: "ユ (yu)", type: .vowel),
        KoreanCharacter(korean: "ㅡ", pronunciation: "ウ (eu)", type: .vowel),
        KoreanCharacter(korean: "ㅣ", pronunciation: "イ (i)", type: .vowel),
        // 複合母音
        KoreanCharacter(korean: "ㅐ", pronunciation: "エ (ae)", type: .vowel),
        KoreanCharacter(korean: "ㅒ", pronunciation: "イェ (yae)", type: .vowel),
        KoreanCharacter(korean: "ㅔ", pronunciation: "エ (e)", type: .vowel),
        KoreanCharacter(korean: "ㅖ", pronunciation: "イェ (ye)", type: .vowel),
        KoreanCharacter(korean: "ㅘ", pronunciation: "ワ (wa)", type: .vowel),
        KoreanCharacter(korean: "ㅙ", pronunciation: "ウェ (wae)", type: .vowel),
        KoreanCharacter(korean: "ㅚ", pronunciation: "ウェ (oe)", type: .vowel),
        KoreanCharacter(korean: "ㅝ", pronunciation: "ウォ (wo)", type: .vowel),
        KoreanCharacter(korean: "ㅞ", pronunciation: "ウェ (we)", type: .vowel),
        KoreanCharacter(korean: "ㅟ", pronunciation: "ウィ (wi)", type: .vowel),
        KoreanCharacter(korean: "ㅢ", pronunciation: "ウィ (ui)", type: .vowel)
    ]
    
    static let allCharacters: [KoreanCharacter] = consonants + vowels
}
