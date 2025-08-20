import Foundation

struct KoreanSentence: Identifiable, Codable, Equatable {
    let id = UUID()
    let korean: String
    let pronunciation: String
    let japanese: String
    let english: String
    let category: SentenceCategory
    let difficulty: DifficultyLevel
    let tags: [String]
    
    enum SentenceCategory: String, CaseIterable, Codable, Equatable {
        case daily = "日常会話"
        case business = "ビジネス"
        case travel = "旅行"
        case food = "食事"
        case shopping = "買い物"
        case weather = "天気"
        case family = "家族"
        case study = "勉強"
        case work = "仕事"
        case hobby = "趣味"
        
        var color: String {
            switch self {
            case .daily: return "blue"
            case .business: return "purple"
            case .travel: return "green"
            case .food: return "orange"
            case .shopping: return "pink"
            case .weather: return "cyan"
            case .family: return "red"
            case .study: return "indigo"
            case .work: return "brown"
            case .hobby: return "mint"
            }
        }
    }
    
    enum DifficultyLevel: String, CaseIterable, Codable, Equatable {
        case beginner = "初級"
        case intermediate = "中級"
        case advanced = "上級"
        
        var color: String {
            switch self {
            case .beginner: return "green"
            case .intermediate: return "orange"
            case .advanced: return "red"
            }
        }
    }
}

// 韓国語文章データベース（長文学習用）
class KoreanSentenceData {
    static let sentences: [KoreanSentence] = [
        // 日常会話 - 初級
        KoreanSentence(
            korean: "안녕하세요! 오늘 날씨가 정말 좋네요.",
            pronunciation: "annyeonghaseyo! oneul nalssiga jeongmal joahneyo.",
            japanese: "こんにちは！今日は天気が本当にいいですね。",
            english: "Hello! The weather is really nice today.",
            category: .daily,
            difficulty: .beginner,
            tags: ["挨拶", "天気", "日常"]
        ),
        
        KoreanSentence(
            korean: "저는 한국어를 배우고 있어요. 아직 어려워요.",
            pronunciation: "jeoneun hangugeoreul baeugo isseoyo. ajik eoryeowoyo.",
            japanese: "私は韓国語を勉強しています。まだ難しいです。",
            english: "I am learning Korean. It's still difficult.",
            category: .study,
            difficulty: .beginner,
            tags: ["勉強", "韓国語", "学習"]
        ),
        
        KoreanSentence(
            korean: "한국 음식을 좋아해요. 김치가 제일 맛있어요.",
            pronunciation: "hanguk eumsigeul joahaeyo. gimchiga jeil masisseoyo.",
            japanese: "韓国料理が好きです。キムチが一番おいしいです。",
            english: "I like Korean food. Kimchi is the most delicious.",
            category: .food,
            difficulty: .beginner,
            tags: ["料理", "キムチ", "食べ物"]
        ),
        
        // 日常会話 - 中級
        KoreanSentence(
            korean: "내일 친구와 함께 영화를 보러 갈 예정이에요.",
            pronunciation: "naeil chinguwa hamkke yeonghwareul boreo gal yejeongieyo.",
            japanese: "明日友達と一緒に映画を見に行く予定です。",
            english: "I'm planning to go see a movie with my friend tomorrow.",
            category: .daily,
            difficulty: .intermediate,
            tags: ["映画", "友達", "予定"]
        ),
        
        KoreanSentence(
            korean: "지하철을 타고 회사에 다니고 있어요. 편리해요.",
            pronunciation: "jihacheoreul tago hoesaee danigo isseoyo. pyeonrihaeyo.",
            japanese: "地下鉄に乗って会社に通っています。便利です。",
            english: "I commute to work by subway. It's convenient.",
            category: .work,
            difficulty: .intermediate,
            tags: ["通勤", "地下鉄", "会社"]
        ),
        
        KoreanSentence(
            korean: "주말에 가족들과 함께 공원에서 피크닉을 했어요.",
            pronunciation: "jumare gajokdeulgwa hamkke gongwoneseo pikeunigeul haesseoyo.",
            japanese: "週末に家族と一緒に公園でピクニックをしました。",
            english: "I had a picnic with my family at the park on the weekend.",
            category: .family,
            difficulty: .intermediate,
            tags: ["家族", "ピクニック", "週末"]
        ),
        
        // ビジネス - 中級
        KoreanSentence(
            korean: "회의가 오후 2시에 시작될 예정입니다.",
            pronunciation: "hoeuiga ohu du sie sijakdoel yejeongimnida.",
            japanese: "会議は午後2時に開始予定です。",
            english: "The meeting is scheduled to start at 2 PM.",
            category: .business,
            difficulty: .intermediate,
            tags: ["会議", "ビジネス", "予定"]
        ),
        
        KoreanSentence(
            korean: "프로젝트 보고서를 이번 주 금요일까지 제출해 주세요.",
            pronunciation: "peurojekteu bogoseoreul ibeon ju geumyoilkkaji jechulhae juseyo.",
            japanese: "プロジェクト報告書を今週金曜日まで提出してください。",
            english: "Please submit the project report by this Friday.",
            category: .business,
            difficulty: .intermediate,
            tags: ["報告書", "提出", "プロジェクト"]
        ),
        
        // 旅行 - 中級
        KoreanSentence(
            korean: "서울에 여행을 가고 싶어요. 명소를 많이 구경하고 싶어요.",
            pronunciation: "seoure yeohaengeul gago sipeoyo. myeongsoreul mani gugyeonghago sipeoyo.",
            japanese: "ソウルに旅行に行きたいです。名所をたくさん見学したいです。",
            english: "I want to travel to Seoul. I want to see many tourist spots.",
            category: .travel,
            difficulty: .intermediate,
            tags: ["旅行", "ソウル", "観光"]
        ),
        
        KoreanSentence(
            korean: "호텔 예약을 미리 해두는 것이 좋을 것 같아요.",
            pronunciation: "hotel yeyageul miri haeduneun geosi joeul geot gatayo.",
            japanese: "ホテルの予約を事前にしておくのがいいと思います。",
            english: "I think it would be good to book a hotel in advance.",
            category: .travel,
            difficulty: .intermediate,
            tags: ["ホテル", "予約", "旅行準備"]
        ),
        
        // 上級 - 複雑な文章
        KoreanSentence(
            korean: "한국어를 배우면서 한국 문화에 대한 이해가 깊어졌어요.",
            pronunciation: "hangugeoreul baeumyeonseo hanguk munhwae daehan ihaege gipeojyeosseoyo.",
            japanese: "韓国語を勉強しながら韓国文化への理解が深まりました。",
            english: "While learning Korean, my understanding of Korean culture has deepened.",
            category: .study,
            difficulty: .advanced,
            tags: ["文化", "理解", "学習効果"]
        ),
        
        KoreanSentence(
            korean: "비즈니스 협상을 위해서는 상대방의 문화적 배경을 이해하는 것이 중요합니다.",
            pronunciation: "bijeuniseu hyeopsangeul wihaeseoneun sangdaebangui munhwajeok baegyeongeul ihaehaneun geosi jungyohamnida.",
            japanese: "ビジネス交渉のためには相手の文化的背景を理解することが重要です。",
            english: "For business negotiations, it is important to understand the cultural background of the other party.",
            category: .business,
            difficulty: .advanced,
            tags: ["交渉", "文化", "ビジネス"]
        ),
        
        KoreanSentence(
            korean: "한국의 계절별 음식 문화는 매우 다양하고 풍부합니다.",
            pronunciation: "hangukui gyejeolbyeol eumsik munhwaneun maeu dayanghago pungbuhamnida.",
            japanese: "韓国の季節別食文化は非常に多様で豊富です。",
            english: "Korea's seasonal food culture is very diverse and rich.",
            category: .food,
            difficulty: .advanced,
            tags: ["季節", "食文化", "多様性"]
        ),
        
        // 買い物 - 中級
        KoreanSentence(
            korean: "이 옷이 얼마예요? 할인을 받을 수 있어요?",
            pronunciation: "i osi eolmayeyo? harineul badeul su isseoyo?",
            japanese: "この服はいくらですか？割引を受けられますか？",
            english: "How much is this clothing? Can I get a discount?",
            category: .shopping,
            difficulty: .intermediate,
            tags: ["買い物", "値段", "割引"]
        ),
        
        KoreanSentence(
            korean: "신용카드로 결제할 수 있어요? 현금이 더 편해요.",
            pronunciation: "sinyongkadeuro gyeoljehal su isseoyo? hyeongeumi deo pyeonhaeyo.",
            japanese: "クレジットカードで支払いできますか？現金の方が便利です。",
            english: "Can I pay by credit card? Cash is more convenient.",
            category: .shopping,
            difficulty: .intermediate,
            tags: ["支払い", "カード", "現金"]
        ),
        
        // 天気 - 初級
        KoreanSentence(
            korean: "오늘은 비가 올 것 같아요. 우산을 가져가는 것이 좋겠어요.",
            pronunciation: "oneureun biga ol geot gatayo. usaneul gajyeoganeun geosi jokesseoyo.",
            japanese: "今日は雨が降りそうです。傘を持っていくのがいいでしょう。",
            english: "It looks like it will rain today. It would be good to bring an umbrella.",
            category: .weather,
            difficulty: .beginner,
            tags: ["天気", "雨", "傘"]
        ),
        
        KoreanSentence(
            korean: "겨울에는 날씨가 추워서 따뜻한 옷을 입어야 해요.",
            pronunciation: "gyeoureneun nalssiga chuwo서o ttatteutan oseul ibeoya haeyo.",
            japanese: "冬は天気が寒いので暖かい服を着なければなりません。",
            english: "In winter, the weather is cold so you have to wear warm clothes.",
            category: .weather,
            difficulty: .beginner,
            tags: ["冬", "寒さ", "服装"]
        ),
        
        // 趣味 - 中級
        KoreanSentence(
            korean: "저는 주말에 등산을 하는 것을 좋아해요. 건강에도 좋고 스트레스 해소에도 도움이 돼요.",
            pronunciation: "jeoneun jumare deungsaneul haneun geoseul joahaeyo. geongangedo joko seuteureseu haesoedo doumi dwaeyo.",
            japanese: "私は週末に登山をするのが好きです。健康にも良くてストレス解消にも役立ちます。",
            english: "I like hiking on weekends. It's good for health and helps relieve stress.",
            category: .hobby,
            difficulty: .intermediate,
            tags: ["登山", "健康", "ストレス解消"]
        ),
        
        KoreanSentence(
            korean: "요리하는 것을 좋아해요. 새로운 레시피를 시도해보는 것이 재미있어요.",
            pronunciation: "yorihaneun geoseul joahaeyo. saeroun resipireul sidohaeboneun geosi jaemiisseoyo.",
            japanese: "料理をするのが好きです。新しいレシピに挑戦してみるのが楽しいです。",
            english: "I like cooking. It's fun to try new recipes.",
            category: .hobby,
            difficulty: .intermediate,
            tags: ["料理", "レシピ", "趣味"]
        )
    ]
    
    // カテゴリ別に文章を取得
    static func getSentencesByCategory(_ category: KoreanSentence.SentenceCategory) -> [KoreanSentence] {
        return sentences.filter { $0.category == category }
    }
    
    // 難易度別に文章を取得
    static func getSentencesByDifficulty(_ difficulty: KoreanSentence.DifficultyLevel) -> [KoreanSentence] {
        return sentences.filter { $0.difficulty == difficulty }
    }
    
    // タグで文章を検索
    static func getSentencesByTag(_ tag: String) -> [KoreanSentence] {
        return sentences.filter { $0.tags.contains(tag) }
    }
    
    // 全文検索
    static func searchSentences(_ query: String) -> [KoreanSentence] {
        let lowercasedQuery = query.lowercased()
        return sentences.filter { sentence in
            sentence.korean.lowercased().contains(lowercasedQuery) ||
            sentence.japanese.lowercased().contains(lowercasedQuery) ||
            sentence.english.lowercased().contains(lowercasedQuery) ||
            sentence.tags.contains { $0.lowercased().contains(lowercasedQuery) }
        }
    }
}
