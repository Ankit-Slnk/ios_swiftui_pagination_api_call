//
//  Reachability.swift
//  ios-swiftui-pagination-api-call
//
//  Created by Ankit Solanki on 25/11/20.
//

import Foundation
import Alamofire

class Reachability {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

