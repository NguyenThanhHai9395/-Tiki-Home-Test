//
//  APIManager.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/25/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import Foundation
import Alamofire

enum APIManager {
    case getProduct
}

extension APIManager{
    var baseURL:String {
        return "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com"
    }
    
    var url: String {
        var path:String = ""
        switch self {
        case .getProduct:
            path = "/ios/keywords.json"
        }
        return baseURL + path
    }
    
    
    var method: HTTPMethod{
        switch self {
        case .getProduct:
            return HTTPMethod.get
        }
    }
    
    var header: [String:String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding{
        switch self {
        default:
            return URLEncoding.default
        }
    }
}
