//
//  ImageAPIClient.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImages(from keyWord: String, completionHandler: @escaping ([Image]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let apiKey = "7289848-451c3dc743d77a89fabd39354"
        let searchKeyword = keyWord.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://pixabay.com/api?key=\(apiKey)&q=\(searchKeyword)"
        
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.manager.getData(
            from: request,
            completionHandler: { (data) in
                do {
                    let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    
                    let onlineImages = results.images
                    
                    completionHandler(onlineImages)
                    
                } catch let error {
                    errorHandler(AppError.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
    }
}
