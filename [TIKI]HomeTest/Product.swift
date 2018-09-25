//
//  Product.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/25/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import Foundation

struct Keyword: Decodable {
    let keywords: [Product]
    
    static func getProduct1(result: @escaping (_ error: String?, _ product: [Product]?) -> Void){
        APIController.request(responseType: Keyword.self, manager: APIManager.getProduct) { (error, response) in
            if error != nil {
                result(error, nil)
            } else {
                result(nil, response?.keywords)
            }
        }
    }
    
    
}

extension Keyword{
    static func getProduct( result: @escaping (_ error: String?, _ result: [Product]?) -> Void){
        APIController.request(responseType: Keyword.self, manager: .getProduct) { (error, response) in
            if let keyword = response {
                result(nil, (keyword.keywords))
            } else {
                result(error, [])
            }
        }
    }
}

struct Product: Decodable{
    let keyword: String?
    let icon: String?
    
}
