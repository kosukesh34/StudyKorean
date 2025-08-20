//
//  KoreanWord.swift
//  StudyKorean
//
//  Created by Kosuke Shigematsu on 8/20/25.
//

import Foundation

struct KoreanWord: Identifiable, Codable {
    let id = UUID()
    let korean: String
    let pronunciation: String
    let japanese: String
    let category: WordCategory
    
    enum WordCategory: String, CaseIterable, Codable {
        case greetings = "挨拶"
        case family = "家族"
        case food = "食べ物"
        case time = "時間"
        case colors = "色"
        case numbers = "数字"
        case body = "体"
        case nature = "自然"
        case transportation = "交通"
        case clothing = "服装"
        case emotions = "感情"
        case daily = "日常"
        case work = "仕事"
        case shopping = "買い物"
        case travel = "旅行"
    }
}

// 韓国語単語データベース（一部のサンプル - 実際は2000単語）
class KoreanWordData {
    static let words: [KoreanWord] = [
        // 挨拶
        KoreanWord(korean: "안녕하세요", pronunciation: "アンニョンハセヨ", japanese: "こんにちは", category: .greetings),
        KoreanWord(korean: "안녕히 가세요", pronunciation: "アンニョンヒ ガセヨ", japanese: "さようなら（見送る時）", category: .greetings),
        KoreanWord(korean: "감사합니다", pronunciation: "カムサハムニダ", japanese: "ありがとうございます", category: .greetings),
        KoreanWord(korean: "죄송합니다", pronunciation: "チェソンハムニダ", japanese: "すみません", category: .greetings),
        KoreanWord(korean: "처음 뵙겠습니다", pronunciation: "チョウム ベプケッスムニダ", japanese: "はじめまして", category: .greetings),
        
        // 家族
        KoreanWord(korean: "가족", pronunciation: "カジョク", japanese: "家族", category: .family),
        KoreanWord(korean: "아버지", pronunciation: "アボジ", japanese: "父", category: .family),
        KoreanWord(korean: "어머니", pronunciation: "オモニ", japanese: "母", category: .family),
        KoreanWord(korean: "형", pronunciation: "ヒョン", japanese: "兄（男性から）", category: .family),
        KoreanWord(korean: "누나", pronunciation: "ヌナ", japanese: "姉（男性から）", category: .family),
        KoreanWord(korean: "동생", pronunciation: "ドンセン", japanese: "弟・妹", category: .family),
        
        // 食べ物
        KoreanWord(korean: "음식", pronunciation: "ウムシク", japanese: "食べ物", category: .food),
        KoreanWord(korean: "밥", pronunciation: "パプ", japanese: "ご飯", category: .food),
        KoreanWord(korean: "물", pronunciation: "ムル", japanese: "水", category: .food),
        KoreanWord(korean: "김치", pronunciation: "キムチ", japanese: "キムチ", category: .food),
        KoreanWord(korean: "불고기", pronunciation: "プルゴギ", japanese: "プルコギ", category: .food),
        KoreanWord(korean: "비빔밥", pronunciation: "ビビムパプ", japanese: "ビビンバ", category: .food),
        
        // 時間
        KoreanWord(korean: "시간", pronunciation: "シガン", japanese: "時間", category: .time),
        KoreanWord(korean: "오늘", pronunciation: "オヌル", japanese: "今日", category: .time),
        KoreanWord(korean: "어제", pronunciation: "オジェ", japanese: "昨日", category: .time),
        KoreanWord(korean: "내일", pronunciation: "ネイル", japanese: "明日", category: .time),
        KoreanWord(korean: "아침", pronunciation: "アチム", japanese: "朝", category: .time),
        KoreanWord(korean: "점심", pronunciation: "チョムシム", japanese: "昼", category: .time),
        KoreanWord(korean: "저녁", pronunciation: "チョニョク", japanese: "夜", category: .time),
        
        // 色
        KoreanWord(korean: "색깔", pronunciation: "セッカル", japanese: "色", category: .colors),
        KoreanWord(korean: "빨간색", pronunciation: "パルガンセク", japanese: "赤", category: .colors),
        KoreanWord(korean: "파란색", pronunciation: "パランセク", japanese: "青", category: .colors),
        KoreanWord(korean: "노란색", pronunciation: "ノランセク", japanese: "黄色", category: .colors),
        KoreanWord(korean: "검은색", pronunciation: "コムンセク", japanese: "黒", category: .colors),
        KoreanWord(korean: "하얀색", pronunciation: "ハヤンセク", japanese: "白", category: .colors),
        
        // 数字
        KoreanWord(korean: "하나", pronunciation: "ハナ", japanese: "一つ", category: .numbers),
        KoreanWord(korean: "둘", pronunciation: "ドゥル", japanese: "二つ", category: .numbers),
        KoreanWord(korean: "셋", pronunciation: "セッ", japanese: "三つ", category: .numbers),
        KoreanWord(korean: "넷", pronunciation: "ネッ", japanese: "四つ", category: .numbers),
        KoreanWord(korean: "다섯", pronunciation: "タソッ", japanese: "五つ", category: .numbers),
        
        // 体
        KoreanWord(korean: "몸", pronunciation: "モム", japanese: "体", category: .body),
        KoreanWord(korean: "머리", pronunciation: "モリ", japanese: "頭", category: .body),
        KoreanWord(korean: "눈", pronunciation: "ヌン", japanese: "目", category: .body),
        KoreanWord(korean: "코", pronunciation: "コ", japanese: "鼻", category: .body),
        KoreanWord(korean: "입", pronunciation: "イプ", japanese: "口", category: .body),
        KoreanWord(korean: "손", pronunciation: "ソン", japanese: "手", category: .body),
        KoreanWord(korean: "발", pronunciation: "パル", japanese: "足", category: .body),
        
        // 自然
        KoreanWord(korean: "자연", pronunciation: "チャヨン", japanese: "自然", category: .nature),
        KoreanWord(korean: "하늘", pronunciation: "ハヌル", japanese: "空", category: .nature),
        KoreanWord(korean: "바다", pronunciation: "パダ", japanese: "海", category: .nature),
        KoreanWord(korean: "산", pronunciation: "サン", japanese: "山", category: .nature),
        KoreanWord(korean: "나무", pronunciation: "ナム", japanese: "木", category: .nature),
        KoreanWord(korean: "꽃", pronunciation: "コッ", japanese: "花", category: .nature),
        
        // 交通
        KoreanWord(korean: "교통", pronunciation: "キョトン", japanese: "交通", category: .transportation),
        KoreanWord(korean: "자동차", pronunciation: "チャドンチャ", japanese: "自動車", category: .transportation),
        KoreanWord(korean: "지하철", pronunciation: "チハチョル", japanese: "地下鉄", category: .transportation),
        KoreanWord(korean: "버스", pronunciation: "ボス", japanese: "バス", category: .transportation),
        KoreanWord(korean: "비행기", pronunciation: "ピヘンギ", japanese: "飛行機", category: .transportation),
        
        // 服装
        KoreanWord(korean: "옷", pronunciation: "オッ", japanese: "服", category: .clothing),
        KoreanWord(korean: "바지", pronunciation: "パジ", japanese: "ズボン", category: .clothing),
        KoreanWord(korean: "치마", pronunciation: "チマ", japanese: "スカート", category: .clothing),
        KoreanWord(korean: "신발", pronunciation: "シンバル", japanese: "靴", category: .clothing),
        
        // 感情
        KoreanWord(korean: "감정", pronunciation: "カムジョン", japanese: "感情", category: .emotions),
        KoreanWord(korean: "기쁘다", pronunciation: "キップダ", japanese: "嬉しい", category: .emotions),
        KoreanWord(korean: "슬프다", pronunciation: "スルプダ", japanese: "悲しい", category: .emotions),
        KoreanWord(korean: "화나다", pronunciation: "ファナダ", japanese: "怒る", category: .emotions),
        KoreanWord(korean: "사랑", pronunciation: "サラン", japanese: "愛", category: .emotions),
        
        // 日常
        KoreanWord(korean: "집", pronunciation: "チプ", japanese: "家", category: .daily),
        KoreanWord(korean: "학교", pronunciation: "ハッキョ", japanese: "学校", category: .daily),
        KoreanWord(korean: "회사", pronunciation: "フェサ", japanese: "会社", category: .daily),
        KoreanWord(korean: "병원", pronunciation: "ピョンウォン", japanese: "病院", category: .daily),
        KoreanWord(korean: "은행", pronunciation: "ウンヘン", japanese: "銀行", category: .daily),
        KoreanWord(korean: "우체국", pronunciation: "ウチェグク", japanese: "郵便局", category: .daily),
        
        // 仕事
        KoreanWord(korean: "일", pronunciation: "イル", japanese: "仕事", category: .work),
        KoreanWord(korean: "선생님", pronunciation: "ソンセンニム", japanese: "先生", category: .work),
        KoreanWord(korean: "학생", pronunciation: "ハクセン", japanese: "学生", category: .work),
        KoreanWord(korean: "의사", pronunciation: "ウィサ", japanese: "医者", category: .work),
        
        // 買い物
        KoreanWord(korean: "쇼핑", pronunciation: "ショピン", japanese: "ショッピング", category: .shopping),
        KoreanWord(korean: "시장", pronunciation: "シジャン", japanese: "市場", category: .shopping),
        KoreanWord(korean: "돈", pronunciation: "トン", japanese: "お金", category: .shopping),
        KoreanWord(korean: "값", pronunciation: "カプ", japanese: "値段", category: .shopping),
        
        // 旅行
        KoreanWord(korean: "여행", pronunciation: "ヨヘン", japanese: "旅行", category: .travel),
        KoreanWord(korean: "호텔", pronunciation: "ホテル", japanese: "ホテル", category: .travel),
        KoreanWord(korean: "공항", pronunciation: "コンハン", japanese: "空港", category: .travel),
        KoreanWord(korean: "기차역", pronunciation: "キチャヨク", japanese: "駅", category: .travel)
    ]
    
    // カテゴリ別に単語を取得
    static func words(for category: KoreanWord.WordCategory) -> [KoreanWord] {
        return words.filter { $0.category == category }
    }
    
    // ランダムな単語を取得
    static func randomWords(count: Int) -> [KoreanWord] {
        return Array(words.shuffled().prefix(count))
    }
}
