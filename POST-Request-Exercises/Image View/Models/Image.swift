//
//  Image.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let numberOfLikes: Int
    let numberOfFavorites: Int
    let tags: String
    let numberOfViews: Int
    let numberOfDownloads: Int
    let thumbnailURLString: String
    let fullSizeURLString: String
    let userName: String
    let userImageURLString: String
    
    enum CodingKeys: String, CodingKey {
        case numberOfLikes = "likes"
        case numberOfFavorites = "favorites"
        case tags
        case numberOfViews = "views"
        case numberOfDownloads = "downloads"
        case thumbnailURLString = "previewURL"
        case fullSizeURLString = "webformatURL"
        case userName = "user"
        case userImageURLString = "userImageURL"
    }
}
