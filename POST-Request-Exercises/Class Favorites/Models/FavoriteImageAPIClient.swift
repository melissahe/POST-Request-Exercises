//
//  FavoriteImageAPIClient.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

class FavoriteImageAPIClient {
    private init() {}
    static let manager = FavoriteImageAPIClient()
    private let urlString = "https://api.fieldbook.com/v1/5a25f6ad306a170300b666d4/images"
    func getImages(completionHandler: @escaping ([FavoriteImage]) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        //begin header injection - turn urlString into a urlRequest
        
        guard let basicAuthRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlString, httpMethod: .GET) else {
            errorHandler(AppError.badURL)
            return
        }
        
        //end header injection
        
        NetworkHelper.manager.getData(
            from: basicAuthRequest,
            completionHandler: { (data) in
                do {
                    let images = try JSONDecoder().decode([FavoriteImage].self, from: data)
                    completionHandler(images)
                } catch {
                    errorHandler(AppError.couldNotParseJSON(rawError: error))
                }
        },
            errorHandler: errorHandler)
    }

    //function used to post stuff
    func post(favoriteImage: FavoriteImage, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        //1. get auth request from url string
        guard var basicAuthRequest = BasicAuthRequest.generate.buildAuthRequest(from: urlString, httpMethod: .POST) else {
            errorHandler(AppError.badURL)
            return
        }
        
        //2. encode foundation objection into json data (so api can use it), and then
        do {
            let encodedImage = try JSONEncoder().encode(favoriteImage)
            
            //3. add that data to the http body of the authorized url request (the body is the message of the content)
            basicAuthRequest.httpBody = encodedImage
        } catch let error {
            errorHandler(AppError.couldNotParseJSON(rawError: error))
        }
        
        //Now perform network request with url request, which has the data that you want to upload and the right authorizations
        
        NetworkHelper.manager.getData(from: basicAuthRequest, completionHandler: completionHandler, errorHandler: errorHandler)
        
    }
    
}
