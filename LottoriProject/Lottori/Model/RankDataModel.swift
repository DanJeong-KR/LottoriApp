

import Foundation


struct RankDataModel {
    var th: Int
    var originBallNums: [String]
    var equalBallIdx: [Int] //
    var rank: Int
    var money: Int
}

struct LottoDataModel {
    var date: String // 발표 날짜
    var round: Int // 회차
    
    var num1: Int // 볼 숫자
    var num2: Int
    var num3: Int
    var num4: Int
    var num5: Int
    var num6: Int
    var numBonus: Int // 보너스 볼
}
