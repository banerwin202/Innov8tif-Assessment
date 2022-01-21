//
//  HTTPHelper.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 20/01/2022.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HTTPHelper: NSObject, NSURLConnectionDelegate {
    class func request(_ url: String,
                       method: HTTPMethod!,
                       body: Parameters? = nil,
                       completion:@escaping([String : Any])->Void){
        URLCache.shared.removeAllCachedResponses()

        var request = URLRequest(url: URL(string: url)!)
        request.cachePolicy = .reloadIgnoringCacheData
        request.httpMethod = method.rawValue
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.urlCache = nil
        manager.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(url, method: method, parameters: body, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            
            print(url)
            print(response)
            
//            if response.response?.statusCode != 200 {
//                CircularSpinner.hide()
//            }
            
            
            if response.result.value is NSDictionary {
                completion(response.result.value as! [String : Any])
            }
            else if response.result.value is NSArray {
                let array = response.result.value as! [[String : Any]]
                let dic = ["responseKey": array ]
                completion(dic)
            }
            else {
                let dic = ["responseKey": "success"]
                completion(dic)
            }
        }
    }
}

