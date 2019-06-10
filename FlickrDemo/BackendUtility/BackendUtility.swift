//
//  BackendUtility.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/9/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit
import Foundation

class BackendUtility: NSObject {

    internal typealias CompletionBlock = (_ inner: () throws -> AnyObject?) -> Void
    
    //enpoint + parameter + httpmethod to call api
    class func requestWithURL(endPointURL: String, parameters: [String: AnyObject]?, method: String,  andCompletionBlock compBlock: @escaping CompletionBlock) {
        let session = URLSession.shared
        var request: URLRequest?
        let urlString = endPointURL + convertToUrlParameter(parameters)
        request = URLRequest(url: URL(string: urlString)!)
        request!.httpMethod = method
        print("=============================CALLING API=============================")
        print(urlString)
        session.dataTask(with: request!) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 1 || httpResponse.statusCode == 100 || httpResponse.statusCode == 105 || httpResponse.statusCode == 106 || httpResponse.statusCode == 111 || httpResponse.statusCode == 112 || httpResponse.statusCode == 114 || httpResponse.statusCode == 115 || httpResponse.statusCode == 116 {
                    print("Fail Call")
                    return
                }
                if let data = data {
                
                    guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
                        return
                    }
                      compBlock { jsonDict as AnyObject }
                    
                } else {
                    print("Error")
                }
                return
            } else {
                print("Error")
            }
            }.resume()
    }
    
    //helper method to format url
    class func convertToUrlParameter(_ dict: [String: AnyObject]?) -> String {
        var parameterString: String = ""
        var i: Int = 0
        if let dict = dict {
            for (key, value) in dict {
                if i > 0 && i < dict.count {
                    parameterString += "&"
                }
                parameterString += "\(key)=\(value)"
                i += 1
            }
        }
        return parameterString
    }
}

