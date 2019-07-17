

import Foundation
import UIKit

final class Lottori {
    //MARK: - 당첨자 인터뷰 이미지.
    static let image = ["396_1", "396_2", "397", "401", "403", "404", "406", "409"].compactMap { UIImage(named: $0)}
    
    // MARK: - 중복하지 않은 랜덤볼 생성하는 함수
    /*
     input : [Int] / 선택한 고정수의 배열이 인수로 들어올 것
     return : [String] / 선택한 고정수의 개수에 따라 랜덤볼을 생성한다.
     */
    static func randomBallGenerator (paramArr: [Int]) -> [String] {
        
        var result:[Int] = paramArr.filter{ $0 != 0 } // 고정수에 따라 결과값 다르게 만들거야.
        
        while result.count < 6 {
            let random = (1...45).randomElement()
            if !result.contains(random!) { // 같은 숫자 나오면 루프 다시 돌게해서 같은 숫자 안나오게
                result.append(random!)
            }
        }
        return result.sorted().map{ String($0) }
    }
    
    //MARK: - 볼의 색 결정하는 함수
    // 1 ~ 10 / 11 ~ 20 / 21 ~ 30 / 31 ~ 40 / 41 ~ 45
    // 피드백 : closedRange 를 사용가능.
    static func setupBallColor(ballText: String) -> UIColor {
        if FixedData.lottoNumArr[0].contains(ballText) {
            return  #colorLiteral(red: 1, green: 0.8626170754, blue: 0, alpha: 1)
        }else if FixedData.lottoNumArr[1].contains(ballText) {
            return  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else if FixedData.lottoNumArr[2].contains(ballText) {
            return  #colorLiteral(red: 0.9783859849, green: 0.1016718969, blue: 0.1412763, alpha: 1)
        }else if FixedData.lottoNumArr[3].contains(ballText) {
            return  #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }else if FixedData.lottoNumArr[4].contains(ballText) {
            return  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }else {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    //MARK: - 과거순위 알아보고 과거순위 배열을 반환하는 함수
    static func searchPastRanking(inputBallNums: [String]) -> [RankDataModel] {
        
        var returnData:[RankDataModel] = []
        var lottoDatas: [[String]] = []
        
        // 보너스 볼 제외한 데이터 만들기
        //
        for var i in FixedData.allLottoDatas {
            if !i.isEmpty { // 0번째 회차는 비어있는 배열 이므로 구분해준다.
                i.removeLast()
            } else {
                i = [""]
            }
            lottoDatas.append(i)
        }
        // 반복문 돌면서 순위 매기기
        for (idx,nums) in lottoDatas.enumerated() {
            
            // 내가 찍은 번호와 / 데이터 nums 비교하고 맞은 숫자대로 새로운 배열 만듬
            let result = nums.filter{ inputBallNums.contains($0) }
            
            guard returnData.count <= 20 else { break } // 20개 까지만 출력할 것
            
            // 맞은 숫자의 개수에 따라 Switch
            switch result.count {
            case 6:
                let rankData = RankDataModel(th: idx, originBallNums: nums, equalBallIdx: result.map{ nums.firstIndex(of: $0)!}, rank: 1, money: FixedData.firstWinPrize)
                returnData.append(rankData)
            case 5:
                let rankData = RankDataModel(th: idx, originBallNums: nums, equalBallIdx: result.map{ nums.firstIndex(of: $0)!}, rank: 3, money: FixedData.thirdWinPrize)
                returnData.append(rankData)
            case 4:
                let rankData = RankDataModel(th: idx, originBallNums: nums, equalBallIdx: result.map{ nums.firstIndex(of: $0)!}, rank: 4, money: 50000)
                returnData.append(rankData)
            case 3:
                let rankData = RankDataModel(th: idx, originBallNums: nums, equalBallIdx: result.map{ nums.firstIndex(of: $0)!}, rank: 5, money: 5000)
                returnData.append(rankData)
            default:
                continue
            }
        }
        // returnData가 collection 이므로 sorted 로 고차함수 사용해서 정렬후 결과값 리턴하기
        return returnData.sorted{ $1.money < $0.money }
    }

}
