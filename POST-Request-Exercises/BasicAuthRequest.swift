//
//  BasicAuthRequestGenerator.swift
//  POST-Request-Exercises
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

class BasicAuthRequest {
    private init() {}
    static let generate = BasicAuthRequest()
    
    //should return a request
    func buildAuthRequest(from urlString: String, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        //begin adding info to request
        
        let username = "key-5"
        let password = "I2vNXkTKcUY4WUq2MgAk"
        
        let authStr = buildAuthString(username: username, password: password)
        
        //add authorization string to request header to get past basic auth
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        
        if httpMethod == .POST {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else if httpMethod == .GET {
            request.httpMethod = "GET"
        }
        
        //end adding info to request
        
        return request
    }
    
    //should build and return auth string for header injection
    private func buildAuthString(username: String, password: String) -> String {
        //1. convert name and pass to right string format
        let nameAndPassStr = String(format: "%@:%@", username, password)
        
        //2. convert string to data (utf8)
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        
        //3. convert data to string (base-64)
        let base64AuthStr = nameAndPassData.base64EncodedData()
        
        //4. Add basic to the line and return it
        let authStr = "Basic \(base64AuthStr)"
        
        return authStr
    }
    
}
