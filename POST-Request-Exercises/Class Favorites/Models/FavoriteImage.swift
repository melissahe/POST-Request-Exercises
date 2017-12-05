//
//  FavoriteImage.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct FavoriteImage: Codable {
    let imageURLString: String
    let studentName: String
    
    enum CodingKeys: String, CodingKey {
        case imageURLString = "image_link"
        case studentName = "student_name"
    }
}
