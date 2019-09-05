//
//  ServiceError.swift
//  Lottori
//
//  Created by Sicc on 04/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case noData
  case clientError
  case invalidStatusCode
  case invalidFormat
}
