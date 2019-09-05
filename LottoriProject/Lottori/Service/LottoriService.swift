//
//  LottoriService.swift
//  Lottori
//
//  Created by Sicc on 04/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

final class LottoriService {
  let baseURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
  
  func fetchLottoriData(count: Int, completion: @escaping (Result<LottoriData, ServiceError>) -> Void) {
    
    guard let url = baseURL + String(count) else { return  }
    
  }
}
