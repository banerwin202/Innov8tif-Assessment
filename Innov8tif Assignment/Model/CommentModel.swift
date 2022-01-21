//
//  CommentModel.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import Foundation
import ObjectMapper

class GetCommentModel: Mappable {
    var responseKey: [GetCommentDetails]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        responseKey <- map["responseKey"]
    }
    
}

class GetCommentDetails : Mappable {
    var postId : Int?
    var id : Int?
    var name : String?
    var email : String?
    var body : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
        
    }
    
}


