//
//  PostModel.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import Foundation
import ObjectMapper

class GetPostModel: Mappable {
    var responseKey: [GetPostDetails]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        responseKey <- map["responseKey"]
    }
    
}

class GetPostDetails : Mappable {
    var userId : Int?
    var id : Int?
    var title : String?
    var body : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        
    }
    
}


