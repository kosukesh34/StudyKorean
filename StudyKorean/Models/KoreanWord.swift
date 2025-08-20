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

// 韓国語単語データベース（本格的な単語帳）
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
        KoreanWord(korean: "기차역", pronunciation: "キチャヨク", japanese: "駅", category: .travel),
        
        // 追加の挨拶表現
        KoreanWord(korean: "좋은 아침", pronunciation: "チョウン アチム", japanese: "おはよう", category: .greetings),
        KoreanWord(korean: "좋은 밤 되세요", pronunciation: "チョウン パム デセヨ", japanese: "おやすみなさい", category: .greetings),
        KoreanWord(korean: "반갑습니다", pronunciation: "パンガプスムニダ", japanese: "お会いできて嬉しいです", category: .greetings),
        KoreanWord(korean: "잘 가요", pronunciation: "チャル ガヨ", japanese: "行ってらっしゃい", category: .greetings),
        KoreanWord(korean: "다녀왔습니다", pronunciation: "タニョワッスムニダ", japanese: "ただいま", category: .greetings),
        KoreanWord(korean: "어서 오세요", pronunciation: "オソ オセヨ", japanese: "いらっしゃいませ", category: .greetings),
        KoreanWord(korean: "맛있게 드세요", pronunciation: "マシッケ トゥセヨ", japanese: "いただきます", category: .greetings),
        KoreanWord(korean: "잘 먹었습니다", pronunciation: "チャル モゴッスムニダ", japanese: "ごちそうさまでした", category: .greetings),
        
        // 追加の家族表現
        KoreanWord(korean: "할아버지", pronunciation: "ハラボジ", japanese: "祖父", category: .family),
        KoreanWord(korean: "할머니", pronunciation: "ハルモニ", japanese: "祖母", category: .family),
        KoreanWord(korean: "아들", pronunciation: "アドゥル", japanese: "息子", category: .family),
        KoreanWord(korean: "딸", pronunciation: "タル", japanese: "娘", category: .family),
        KoreanWord(korean: "삼촌", pronunciation: "サムチョン", japanese: "おじさん", category: .family),
        KoreanWord(korean: "이모", pronunciation: "イモ", japanese: "おばさん", category: .family),
        KoreanWord(korean: "사촌", pronunciation: "サチョン", japanese: "いとこ", category: .family),
        KoreanWord(korean: "조카", pronunciation: "チョカ", japanese: "甥・姪", category: .family),
        
        // 追加の食べ物
        KoreanWord(korean: "국수", pronunciation: "ククス", japanese: "麺", category: .food),
        KoreanWord(korean: "떡", pronunciation: "トッ", japanese: "餅", category: .food),
        KoreanWord(korean: "만두", pronunciation: "マンドゥ", japanese: "餃子", category: .food),
        KoreanWord(korean: "김밥", pronunciation: "キムパプ", japanese: "キムパプ", category: .food),
        KoreanWord(korean: "된장", pronunciation: "テンチャン", japanese: "テンチャン", category: .food),
        KoreanWord(korean: "고추장", pronunciation: "コチュジャン", japanese: "コチュジャン", category: .food),
        KoreanWord(korean: "소주", pronunciation: "ソジュ", japanese: "焼酎", category: .food),
        KoreanWord(korean: "맥주", pronunciation: "メクチュ", japanese: "ビール", category: .food),
        KoreanWord(korean: "커피", pronunciation: "コピ", japanese: "コーヒー", category: .food),
        KoreanWord(korean: "차", pronunciation: "チャ", japanese: "お茶", category: .food),
        KoreanWord(korean: "우유", pronunciation: "ウユ", japanese: "牛乳", category: .food),
        KoreanWord(korean: "주스", pronunciation: "チュス", japanese: "ジュース", category: .food),
        
        // 追加の時間表現
        KoreanWord(korean: "월요일", pronunciation: "ウォリョイル", japanese: "月曜日", category: .time),
        KoreanWord(korean: "화요일", pronunciation: "ファヨイル", japanese: "火曜日", category: .time),
        KoreanWord(korean: "수요일", pronunciation: "スヨイル", japanese: "水曜日", category: .time),
        KoreanWord(korean: "목요일", pronunciation: "モギョイル", japanese: "木曜日", category: .time),
        KoreanWord(korean: "금요일", pronunciation: "クミョイル", japanese: "金曜日", category: .time),
        KoreanWord(korean: "토요일", pronunciation: "トヨイル", japanese: "土曜日", category: .time),
        KoreanWord(korean: "일요일", pronunciation: "イリョイル", japanese: "日曜日", category: .time),
        KoreanWord(korean: "이번 주", pronunciation: "イボン チュ", japanese: "今週", category: .time),
        KoreanWord(korean: "다음 주", pronunciation: "タウム チュ", japanese: "来週", category: .time),
        KoreanWord(korean: "지난 주", pronunciation: "チナン チュ", japanese: "先週", category: .time),
        KoreanWord(korean: "이번 달", pronunciation: "イボン タル", japanese: "今月", category: .time),
        KoreanWord(korean: "다음 달", pronunciation: "タウム タル", japanese: "来月", category: .time),
        KoreanWord(korean: "지난 달", pronunciation: "チナン タル", japanese: "先月", category: .time),
        KoreanWord(korean: "올해", pronunciation: "オルヘ", japanese: "今年", category: .time),
        KoreanWord(korean: "내년", pronunciation: "ネニョン", japanese: "来年", category: .time),
        KoreanWord(korean: "작년", pronunciation: "チャンニョン", japanese: "去年", category: .time),
        
        // 追加の色
        KoreanWord(korean: "초록색", pronunciation: "チョロクセク", japanese: "緑", category: .colors),
        KoreanWord(korean: "보라색", pronunciation: "ポラセク", japanese: "紫", category: .colors),
        KoreanWord(korean: "주황색", pronunciation: "チュファンセク", japanese: "オレンジ", category: .colors),
        KoreanWord(korean: "분홍색", pronunciation: "プンホンセク", japanese: "ピンク", category: .colors),
        KoreanWord(korean: "회색", pronunciation: "フェセク", japanese: "グレー", category: .colors),
        KoreanWord(korean: "갈색", pronunciation: "カルセク", japanese: "茶色", category: .colors),
        
        // 追加の数字
        KoreanWord(korean: "여섯", pronunciation: "ヨソッ", japanese: "六つ", category: .numbers),
        KoreanWord(korean: "일곱", pronunciation: "イルゴプ", japanese: "七つ", category: .numbers),
        KoreanWord(korean: "여덟", pronunciation: "ヨドル", japanese: "八つ", category: .numbers),
        KoreanWord(korean: "아홉", pronunciation: "アホプ", japanese: "九つ", category: .numbers),
        KoreanWord(korean: "열", pronunciation: "ヨル", japanese: "十", category: .numbers),
        KoreanWord(korean: "스물", pronunciation: "スムル", japanese: "二十", category: .numbers),
        KoreanWord(korean: "서른", pronunciation: "ソルン", japanese: "三十", category: .numbers),
        KoreanWord(korean: "마흔", pronunciation: "マフン", japanese: "四十", category: .numbers),
        KoreanWord(korean: "쉰", pronunciation: "スィン", japanese: "五十", category: .numbers),
        KoreanWord(korean: "백", pronunciation: "ペク", japanese: "百", category: .numbers),
        KoreanWord(korean: "천", pronunciation: "チョン", japanese: "千", category: .numbers),
        KoreanWord(korean: "만", pronunciation: "マン", japanese: "万", category: .numbers),
        
        // 追加の体の部位
        KoreanWord(korean: "얼굴", pronunciation: "オルグル", japanese: "顔", category: .body),
        KoreanWord(korean: "목", pronunciation: "モク", japanese: "首", category: .body),
        KoreanWord(korean: "어깨", pronunciation: "オッケ", japanese: "肩", category: .body),
        KoreanWord(korean: "가슴", pronunciation: "カスム", japanese: "胸", category: .body),
        KoreanWord(korean: "배", pronunciation: "ペ", japanese: "お腹", category: .body),
        KoreanWord(korean: "등", pronunciation: "トゥン", japanese: "背中", category: .body),
        KoreanWord(korean: "무릎", pronunciation: "ムルプ", japanese: "膝", category: .body),
        KoreanWord(korean: "팔", pronunciation: "パル", japanese: "腕", category: .body),
        KoreanWord(korean: "다리", pronunciation: "タリ", japanese: "脚", category: .body),
        KoreanWord(korean: "손가락", pronunciation: "ソンガラク", japanese: "指", category: .body),
        KoreanWord(korean: "발가락", pronunciation: "パルガラク", japanese: "足の指", category: .body),
        KoreanWord(korean: "치아", pronunciation: "チア", japanese: "歯", category: .body),
        KoreanWord(korean: "혀", pronunciation: "ヒョ", japanese: "舌", category: .body),
        KoreanWord(korean: "턱", pronunciation: "トク", japanese: "顎", category: .body),
        KoreanWord(korean: "이마", pronunciation: "イマ", japanese: "額", category: .body),
        KoreanWord(korean: "볼", pronunciation: "ポル", japanese: "頬", category: .body),
        KoreanWord(korean: "털", pronunciation: "トル", japanese: "毛", category: .body),
        
        // 追加の自然
        KoreanWord(korean: "구름", pronunciation: "クルム", japanese: "雲", category: .nature),
        KoreanWord(korean: "비", pronunciation: "ピ", japanese: "雨", category: .nature),
        KoreanWord(korean: "눈", pronunciation: "ヌン", japanese: "雪", category: .nature),
        KoreanWord(korean: "바람", pronunciation: "パラム", japanese: "風", category: .nature),
        KoreanWord(korean: "태양", pronunciation: "テヤン", japanese: "太陽", category: .nature),
        KoreanWord(korean: "달", pronunciation: "タル", japanese: "月", category: .nature),
        KoreanWord(korean: "별", pronunciation: "ピョル", japanese: "星", category: .nature),
        KoreanWord(korean: "강", pronunciation: "カン", japanese: "川", category: .nature),
        KoreanWord(korean: "호수", pronunciation: "ホス", japanese: "湖", category: .nature),
        KoreanWord(korean: "섬", pronunciation: "ソム", japanese: "島", category: .nature),
        KoreanWord(korean: "숲", pronunciation: "スプ", japanese: "森", category: .nature),
        KoreanWord(korean: "풀", pronunciation: "プル", japanese: "草", category: .nature),
        KoreanWord(korean: "잎", pronunciation: "イプ", japanese: "葉", category: .nature),
        KoreanWord(korean: "뿌리", pronunciation: "ップリ", japanese: "根", category: .nature),
        KoreanWord(korean: "씨앗", pronunciation: "シアッ", japanese: "種", category: .nature),
        
        // 追加の交通
        KoreanWord(korean: "택시", pronunciation: "テクシ", japanese: "タクシー", category: .transportation),
        KoreanWord(korean: "자전거", pronunciation: "チャジョンゴ", japanese: "自転車", category: .transportation),
        KoreanWord(korean: "오토바이", pronunciation: "オトバイ", japanese: "バイク", category: .transportation),
        KoreanWord(korean: "배", pronunciation: "ペ", japanese: "船", category: .transportation),
        KoreanWord(korean: "기차", pronunciation: "キチャ", japanese: "電車", category: .transportation),
        KoreanWord(korean: "고속버스", pronunciation: "コソクボス", japanese: "高速バス", category: .transportation),
        KoreanWord(korean: "지하철역", pronunciation: "チハチョリョク", japanese: "地下鉄駅", category: .transportation),
        KoreanWord(korean: "버스정류장", pronunciation: "ボスチョンニュジャン", japanese: "バス停", category: .transportation),
        
        // 追加の服装
        KoreanWord(korean: "셔츠", pronunciation: "ショチュ", japanese: "シャツ", category: .clothing),
        KoreanWord(korean: "양말", pronunciation: "ヤンマル", japanese: "靴下", category: .clothing),
        KoreanWord(korean: "모자", pronunciation: "モジャ", japanese: "帽子", category: .clothing),
        KoreanWord(korean: "장갑", pronunciation: "チャンガプ", japanese: "手袋", category: .clothing),
        KoreanWord(korean: "스카프", pronunciation: "スカプ", japanese: "スカーフ", category: .clothing),
        KoreanWord(korean: "넥타이", pronunciation: "ネクタイ", japanese: "ネクタイ", category: .clothing),
        KoreanWord(korean: "양복", pronunciation: "ヤンボク", japanese: "スーツ", category: .clothing),
        KoreanWord(korean: "운동복", pronunciation: "ウンドンボク", japanese: "運動着", category: .clothing),
        KoreanWord(korean: "수영복", pronunciation: "スヨンボク", japanese: "水着", category: .clothing),
        KoreanWord(korean: "속옷", pronunciation: "ソゴッ", japanese: "下着", category: .clothing),
        
        // 追加の感情
        KoreanWord(korean: "무섭다", pronunciation: "ムソプダ", japanese: "怖い", category: .emotions),
        KoreanWord(korean: "놀라다", pronunciation: "ノルラダ", japanese: "驚く", category: .emotions),
        KoreanWord(korean: "부끄럽다", pronunciation: "プックロプダ", japanese: "恥ずかしい", category: .emotions),
        KoreanWord(korean: "짜증나다", pronunciation: "チャジュンナダ", japanese: "イライラする", category: .emotions),
        KoreanWord(korean: "지루하다", pronunciation: "チルハダ", japanese: "退屈だ", category: .emotions),
        KoreanWord(korean: "재미있다", pronunciation: "チェミイッタ", japanese: "面白い", category: .emotions),
        KoreanWord(korean: "따뜻하다", pronunciation: "タットゥタダ", japanese: "温かい", category: .emotions),
        KoreanWord(korean: "시원하다", pronunciation: "シウォナダ", japanese: "涼しい", category: .emotions),
        KoreanWord(korean: "피곤하다", pronunciation: "ピゴナダ", japanese: "疲れた", category: .emotions),
        KoreanWord(korean: "배고프다", pronunciation: "ペゴプダ", japanese: "お腹が空いた", category: .emotions),
        KoreanWord(korean: "목마르다", pronunciation: "モンマルダ", japanese: "喉が渇いた", category: .emotions),
        
        // 追加の日常
        KoreanWord(korean: "방", pronunciation: "パン", japanese: "部屋", category: .daily),
        KoreanWord(korean: "부엌", pronunciation: "プオク", japanese: "台所", category: .daily),
        KoreanWord(korean: "욕실", pronunciation: "ヨクシル", japanese: "浴室", category: .daily),
        KoreanWord(korean: "화장실", pronunciation: "ファジャンシル", japanese: "トイレ", category: .daily),
        KoreanWord(korean: "침실", pronunciation: "チムシル", japanese: "寝室", category: .daily),
        KoreanWord(korean: "거실", pronunciation: "コシル", japanese: "リビング", category: .daily),
        KoreanWord(korean: "베란다", pronunciation: "ペランダ", japanese: "ベランダ", category: .daily),
        KoreanWord(korean: "계단", pronunciation: "ケダン", japanese: "階段", category: .daily),
        KoreanWord(korean: "엘리베이터", pronunciation: "エリベーター", japanese: "エレベーター", category: .daily),
        KoreanWord(korean: "에어컨", pronunciation: "エアコン", japanese: "エアコン", category: .daily),
        KoreanWord(korean: "히터", pronunciation: "ヒーター", japanese: "ヒーター", category: .daily),
        KoreanWord(korean: "전화", pronunciation: "チョンファ", japanese: "電話", category: .daily),
        KoreanWord(korean: "컴퓨터", pronunciation: "コンピュータ", japanese: "コンピューター", category: .daily),
        KoreanWord(korean: "텔레비전", pronunciation: "テレビジョン", japanese: "テレビ", category: .daily),
        KoreanWord(korean: "라디오", pronunciation: "ラジオ", japanese: "ラジオ", category: .daily),
        
        // 追加の仕事
        KoreanWord(korean: "회사원", pronunciation: "フェサウォン", japanese: "会社員", category: .work),
        KoreanWord(korean: "교수", pronunciation: "キョス", japanese: "教授", category: .work),
        KoreanWord(korean: "간호사", pronunciation: "カンホサ", japanese: "看護師", category: .work),
        KoreanWord(korean: "변호사", pronunciation: "ピョンホサ", japanese: "弁護士", category: .work),
        KoreanWord(korean: "경찰관", pronunciation: "キョンチャルクァン", japanese: "警察官", category: .work),
        KoreanWord(korean: "소방관", pronunciation: "ソバンクァン", japanese: "消防士", category: .work),
        KoreanWord(korean: "기자", pronunciation: "キジャ", japanese: "記者", category: .work),
        KoreanWord(korean: "배우", pronunciation: "ペウ", japanese: "俳優", category: .work),
        KoreanWord(korean: "가수", pronunciation: "カス", japanese: "歌手", category: .work),
        KoreanWord(korean: "화가", pronunciation: "ファガ", japanese: "画家", category: .work),
        KoreanWord(korean: "작가", pronunciation: "チャッカ", japanese: "作家", category: .work),
        KoreanWord(korean: "요리사", pronunciation: "ヨリサ", japanese: "料理人", category: .work),
        KoreanWord(korean: "운전사", pronunciation: "ウンジョンサ", japanese: "運転手", category: .work),
        KoreanWord(korean: "비서", pronunciation: "ピソ", japanese: "秘書", category: .work),
        KoreanWord(korean: "회계사", pronunciation: "フェゲサ", japanese: "会計士", category: .work),
        
        // 追加の買い物
        KoreanWord(korean: "백화점", pronunciation: "ペクファジョム", japanese: "デパート", category: .shopping),
        KoreanWord(korean: "슈퍼마켓", pronunciation: "シューパーマケット", japanese: "スーパーマーケット", category: .shopping),
        KoreanWord(korean: "편의점", pronunciation: "ピョニジョム", japanese: "コンビニ", category: .shopping),
        KoreanWord(korean: "약국", pronunciation: "ヤックク", japanese: "薬局", category: .shopping),
        KoreanWord(korean: "서점", pronunciation: "ソジョム", japanese: "書店", category: .shopping),
        KoreanWord(korean: "옷가게", pronunciation: "オッカゲ", japanese: "洋服店", category: .shopping),
        KoreanWord(korean: "신발가게", pronunciation: "シンバルカゲ", japanese: "靴屋", category: .shopping),
        KoreanWord(korean: "가전제품점", pronunciation: "カジョンジェプムジョム", japanese: "家電店", category: .shopping),
        KoreanWord(korean: "화장품점", pronunciation: "ファジャンプムジョム", japanese: "化粧品店", category: .shopping),
        KoreanWord(korean: "꽃집", pronunciation: "コッチプ", japanese: "花屋", category: .shopping),
        KoreanWord(korean: "미용실", pronunciation: "ミヨンシル", japanese: "美容院", category: .shopping),
        KoreanWord(korean: "이발소", pronunciation: "イバルソ", japanese: "理髪店", category: .shopping),
        KoreanWord(korean: "세탁소", pronunciation: "セタクソ", japanese: "クリーニング", category: .shopping),
        KoreanWord(korean: "수리점", pronunciation: "スリジョム", japanese: "修理店", category: .shopping),
        
        // 追加の旅行
        KoreanWord(korean: "관광지", pronunciation: "クァングァンジ", japanese: "観光地", category: .travel),
        KoreanWord(korean: "박물관", pronunciation: "パンムルクァン", japanese: "博物館", category: .travel),
        KoreanWord(korean: "미술관", pronunciation: "ミスルクァン", japanese: "美術館", category: .travel),
        KoreanWord(korean: "극장", pronunciation: "ククチャン", japanese: "劇場", category: .travel),
        KoreanWord(korean: "영화관", pronunciation: "ヨンファクァン", japanese: "映画館", category: .travel),
        KoreanWord(korean: "공원", pronunciation: "コンウォン", japanese: "公園", category: .travel),
        KoreanWord(korean: "동물원", pronunciation: "トンムルウォン", japanese: "動物園", category: .travel),
        KoreanWord(korean: "놀이공원", pronunciation: "ノリコンウォン", japanese: "遊園地", category: .travel),
        KoreanWord(korean: "해변", pronunciation: "ヘビョン", japanese: "海岸", category: .travel),
        KoreanWord(korean: "온천", pronunciation: "オンチョン", japanese: "温泉", category: .travel),
        KoreanWord(korean: "캠핑장", pronunciation: "キャンピングジャン", japanese: "キャンプ場", category: .travel),
        KoreanWord(korean: "리조트", pronunciation: "リゾート", japanese: "リゾート", category: .travel),
        KoreanWord(korean: "게스트하우스", pronunciation: "ゲストハウス", japanese: "ゲストハウス", category: .travel),
        KoreanWord(korean: "펜션", pronunciation: "ペンション", japanese: "ペンション", category: .travel),
        KoreanWord(korean: "민박", pronunciation: "ミンバク", japanese: "民宿", category: .travel),
        KoreanWord(korean: "여행사", pronunciation: "ヨヘンサ", japanese: "旅行会社", category: .travel),
        KoreanWord(korean: "가이드", pronunciation: "ガイド", japanese: "ガイド", category: .travel),
        KoreanWord(korean: "관광객", pronunciation: "クァングァンゲク", japanese: "観光客", category: .travel),
        KoreanWord(korean: "여권", pronunciation: "ヨグォン", japanese: "パスポート", category: .travel),
        KoreanWord(korean: "비자", pronunciation: "ビジャ", japanese: "ビザ", category: .travel),
        KoreanWord(korean: "입국", pronunciation: "イプクク", japanese: "入国", category: .travel),
        KoreanWord(korean: "출국", pronunciation: "チュルクク", japanese: "出国", category: .travel),
        KoreanWord(korean: "세관", pronunciation: "セグァン", japanese: "税関", category: .travel),
        KoreanWord(korean: "면세점", pronunciation: "ミョンセジョム", japanese: "免税店", category: .travel)
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
