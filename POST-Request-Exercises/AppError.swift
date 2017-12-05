//
//  AppError.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badData
    case badURL
    case badImageURL
    case badStatusCode(num: Int)
    case couldNotParseJSON(rawError: Error)
    case other(rawError: Error)
}
