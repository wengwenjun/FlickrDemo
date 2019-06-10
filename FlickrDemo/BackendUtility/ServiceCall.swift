//
//  ServiceCall.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/9/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit

class ServiceCall: BackendUtility {
    
    static let endPoint = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&"
    static let apiKey = "10ea1291153d56b1d959b3c2e711d739"
    // date + element count want to be returned each page + page number
    class func requestYesterdayInterestingPhoto( date: String, perPage: Int, page: Int, completion: @escaping CompletionBlock) {
        var param = [String: String]()
        param["api_key"] = apiKey
        param["per_page"] = String(perPage)
        param["page"] = String(page)
        param["date"] = date
        param["format"] = "json"
        param["nojsoncallback"] = "1"
        requestWithURL(endPointURL: endPoint, parameters: param as [String: AnyObject]?, method: "GET", andCompletionBlock: completion)
    }
}
