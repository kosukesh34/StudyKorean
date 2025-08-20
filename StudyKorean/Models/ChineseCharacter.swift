//
//  ChineseCharacter.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import Foundation

struct ChineseCharacter: Identifiable, Codable {
    let id = UUID()
    let character: String
    let pinyin: String
    let japanese: String
    let category: CharacterCategory
    
    enum CharacterCategory: String, CaseIterable, Codable {
        case basic = "基本漢字"
        case numbers = "数字"
        case family = "家族"
        case time = "時間"
        case colors = "色"
        case nature = "自然"
        case daily = "日常"
        case food = "食べ物"
        case body = "体"
        case emotions = "感情"
    }
}

// 中国語漢字データ
class ChineseCharacterData {
    static let characters: [ChineseCharacter] = [
        // 基本漢字
        ChineseCharacter(character: "你", pinyin: "nǐ", japanese: "あなた", category: .basic),
        ChineseCharacter(character: "好", pinyin: "hǎo", japanese: "良い", category: .basic),
        ChineseCharacter(character: "我", pinyin: "wǒ", japanese: "私", category: .basic),
        ChineseCharacter(character: "他", pinyin: "tā", japanese: "彼", category: .basic),
        ChineseCharacter(character: "她", pinyin: "tā", japanese: "彼女", category: .basic),
        ChineseCharacter(character: "是", pinyin: "shì", japanese: "〜である", category: .basic),
        ChineseCharacter(character: "的", pinyin: "de", japanese: "〜の", category: .basic),
        ChineseCharacter(character: "在", pinyin: "zài", japanese: "〜にある", category: .basic),
        ChineseCharacter(character: "有", pinyin: "yǒu", japanese: "ある・持つ", category: .basic),
        ChineseCharacter(character: "不", pinyin: "bù", japanese: "〜しない", category: .basic),
        ChineseCharacter(character: "来", pinyin: "lái", japanese: "来る", category: .basic),
        ChineseCharacter(character: "去", pinyin: "qù", japanese: "行く", category: .basic),
        ChineseCharacter(character: "看", pinyin: "kàn", japanese: "見る", category: .basic),
        ChineseCharacter(character: "说", pinyin: "shuō", japanese: "話す", category: .basic),
        ChineseCharacter(character: "听", pinyin: "tīng", japanese: "聞く", category: .basic),
        
        // 数字
        ChineseCharacter(character: "一", pinyin: "yī", japanese: "1", category: .numbers),
        ChineseCharacter(character: "二", pinyin: "èr", japanese: "2", category: .numbers),
        ChineseCharacter(character: "三", pinyin: "sān", japanese: "3", category: .numbers),
        ChineseCharacter(character: "四", pinyin: "sì", japanese: "4", category: .numbers),
        ChineseCharacter(character: "五", pinyin: "wǔ", japanese: "5", category: .numbers),
        ChineseCharacter(character: "六", pinyin: "liù", japanese: "6", category: .numbers),
        ChineseCharacter(character: "七", pinyin: "qī", japanese: "7", category: .numbers),
        ChineseCharacter(character: "八", pinyin: "bā", japanese: "8", category: .numbers),
        ChineseCharacter(character: "九", pinyin: "jiǔ", japanese: "9", category: .numbers),
        ChineseCharacter(character: "十", pinyin: "shí", japanese: "10", category: .numbers),
        ChineseCharacter(character: "百", pinyin: "bǎi", japanese: "100", category: .numbers),
        ChineseCharacter(character: "千", pinyin: "qiān", japanese: "1000", category: .numbers),
        
        // 家族
        ChineseCharacter(character: "家", pinyin: "jiā", japanese: "家・家族", category: .family),
        ChineseCharacter(character: "父", pinyin: "fù", japanese: "父", category: .family),
        ChineseCharacter(character: "母", pinyin: "mǔ", japanese: "母", category: .family),
        ChineseCharacter(character: "儿", pinyin: "ér", japanese: "息子", category: .family),
        ChineseCharacter(character: "女", pinyin: "nǚ", japanese: "娘", category: .family),
        ChineseCharacter(character: "哥", pinyin: "gē", japanese: "兄", category: .family),
        ChineseCharacter(character: "姐", pinyin: "jiě", japanese: "姉", category: .family),
        ChineseCharacter(character: "弟", pinyin: "dì", japanese: "弟", category: .family),
        ChineseCharacter(character: "妹", pinyin: "mèi", japanese: "妹", category: .family),
        
        // 時間
        ChineseCharacter(character: "今", pinyin: "jīn", japanese: "今", category: .time),
        ChineseCharacter(character: "天", pinyin: "tiān", japanese: "日・空", category: .time),
        ChineseCharacter(character: "年", pinyin: "nián", japanese: "年", category: .time),
        ChineseCharacter(character: "月", pinyin: "yuè", japanese: "月", category: .time),
        ChineseCharacter(character: "日", pinyin: "rì", japanese: "日", category: .time),
        ChineseCharacter(character: "时", pinyin: "shí", japanese: "時", category: .time),
        ChineseCharacter(character: "分", pinyin: "fēn", japanese: "分", category: .time),
        ChineseCharacter(character: "早", pinyin: "zǎo", japanese: "早い", category: .time),
        ChineseCharacter(character: "晚", pinyin: "wǎn", japanese: "遅い・夜", category: .time),
        
        // 色
        ChineseCharacter(character: "红", pinyin: "hóng", japanese: "赤", category: .colors),
        ChineseCharacter(character: "黄", pinyin: "huáng", japanese: "黄", category: .colors),
        ChineseCharacter(character: "蓝", pinyin: "lán", japanese: "青", category: .colors),
        ChineseCharacter(character: "绿", pinyin: "lǜ", japanese: "緑", category: .colors),
        ChineseCharacter(character: "白", pinyin: "bái", japanese: "白", category: .colors),
        ChineseCharacter(character: "黑", pinyin: "hēi", japanese: "黒", category: .colors),
        
        // 自然
        ChineseCharacter(character: "山", pinyin: "shān", japanese: "山", category: .nature),
        ChineseCharacter(character: "水", pinyin: "shuǐ", japanese: "水", category: .nature),
        ChineseCharacter(character: "火", pinyin: "huǒ", japanese: "火", category: .nature),
        ChineseCharacter(character: "土", pinyin: "tǔ", japanese: "土", category: .nature),
        ChineseCharacter(character: "木", pinyin: "mù", japanese: "木", category: .nature),
        ChineseCharacter(character: "花", pinyin: "huā", japanese: "花", category: .nature),
        ChineseCharacter(character: "草", pinyin: "cǎo", japanese: "草", category: .nature),
        ChineseCharacter(character: "树", pinyin: "shù", japanese: "木", category: .nature),
        
        // 日常
        ChineseCharacter(character: "吃", pinyin: "chī", japanese: "食べる", category: .daily),
        ChineseCharacter(character: "喝", pinyin: "hē", japanese: "飲む", category: .daily),
        ChineseCharacter(character: "睡", pinyin: "shuì", japanese: "眠る", category: .daily),
        ChineseCharacter(character: "起", pinyin: "qǐ", japanese: "起きる", category: .daily),
        ChineseCharacter(character: "走", pinyin: "zǒu", japanese: "歩く", category: .daily),
        ChineseCharacter(character: "跑", pinyin: "pǎo", japanese: "走る", category: .daily),
        ChineseCharacter(character: "买", pinyin: "mǎi", japanese: "買う", category: .daily),
        ChineseCharacter(character: "卖", pinyin: "mài", japanese: "売る", category: .daily),
        
        // 食べ物
        ChineseCharacter(character: "饭", pinyin: "fàn", japanese: "ご飯", category: .food),
        ChineseCharacter(character: "面", pinyin: "miàn", japanese: "麺", category: .food),
        ChineseCharacter(character: "菜", pinyin: "cài", japanese: "野菜・料理", category: .food),
        ChineseCharacter(character: "肉", pinyin: "ròu", japanese: "肉", category: .food),
        ChineseCharacter(character: "鱼", pinyin: "yú", japanese: "魚", category: .food),
        ChineseCharacter(character: "蛋", pinyin: "dàn", japanese: "卵", category: .food),
        ChineseCharacter(character: "茶", pinyin: "chá", japanese: "茶", category: .food),
        ChineseCharacter(character: "咖", pinyin: "kā", japanese: "コーヒー", category: .food),
        
        // 体
        ChineseCharacter(character: "头", pinyin: "tóu", japanese: "頭", category: .body),
        ChineseCharacter(character: "眼", pinyin: "yǎn", japanese: "目", category: .body),
        ChineseCharacter(character: "口", pinyin: "kǒu", japanese: "口", category: .body),
        ChineseCharacter(character: "手", pinyin: "shǒu", japanese: "手", category: .body),
        ChineseCharacter(character: "脚", pinyin: "jiǎo", japanese: "足", category: .body),
        ChineseCharacter(character: "身", pinyin: "shēn", japanese: "体", category: .body),
        
        // 感情
        ChineseCharacter(character: "爱", pinyin: "ài", japanese: "愛", category: .emotions),
        ChineseCharacter(character: "喜", pinyin: "xǐ", japanese: "喜び", category: .emotions),
        ChineseCharacter(character: "怒", pinyin: "nù", japanese: "怒り", category: .emotions),
        ChineseCharacter(character: "悲", pinyin: "bēi", japanese: "悲しみ", category: .emotions),
        ChineseCharacter(character: "乐", pinyin: "lè", japanese: "楽しい", category: .emotions),
        ChineseCharacter(character: "怕", pinyin: "pà", japanese: "怖い", category: .emotions)
    ]
    
    // カテゴリ別に漢字を取得
    static func characters(for category: ChineseCharacter.CharacterCategory) -> [ChineseCharacter] {
        return characters.filter { $0.category == category }
    }
    
    // ランダムな漢字を取得
    static func randomCharacters(count: Int) -> [ChineseCharacter] {
        return Array(characters.shuffled().prefix(count))
    }
}
