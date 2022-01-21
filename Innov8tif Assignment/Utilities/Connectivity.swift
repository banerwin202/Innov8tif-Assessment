//
//  Connectivity.swift
//  Innov8tif Assignment
//
//  Created by Ban Er Win on 21/01/2022.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
