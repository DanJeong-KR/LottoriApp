

import Foundation
import UIKit

// API 를 받으러고 Codable 프로토콜 채택하는 데이터모델 만듬
struct LottoriCodable: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

