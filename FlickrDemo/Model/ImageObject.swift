//
//  ImageObject.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/9/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit

struct ImageObject {
 
    var farmId: Int
    var isFamily: Int
    var isPublic: Int
    var owner: String
    var serverId: String
    var title: String
    var id: String
    var isFriend: Int
    var secret: String
    
    init(dict: [String: Any]) {
        farmId = dict["farm"] as! Int
        isFamily = dict["isfamily"] as! Int
        isPublic = dict["ispublic"] as! Int
        secret = dict["secret"] as! String
        owner = dict["owner"] as! String
        serverId = dict["server"] as! String
        title = dict["title"] as! String
        id = dict["id"] as! String
        isFriend = dict["isfriend"] as! Int
    }
    
    func getImageData() -> URL?{
        var urlString = "https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg"
        urlString = urlString.replacingOccurrences(of: "{farm-id}", with: String(farmId)).replacingOccurrences(of:"{server-id}", with: serverId).replacingOccurrences(of: "{id}", with: String(id)).replacingOccurrences(of: "{secret}", with: secret)
        let url = URL(string: urlString)
        return url
    }
}
