//
//  ConvertToImage.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

class ConvertToImage {
    private init() {}
    static let tool = ConvertToImage()
    func getImage(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            errorHandler(AppError.badImageURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.manager.getData(
            from: request,
            completionHandler: { (data) in
                guard let image = UIImage(data: data) else {
                    print("couldn't convert data to image")
                    return
                }
                
                completionHandler(image)
        },
            errorHandler: errorHandler)
    }
}
