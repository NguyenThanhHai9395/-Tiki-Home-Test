//
//  APIController.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/25/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import Foundation
import Alamofire

typealias ErrorResponseBlock = (_ error: String?) -> Void
typealias ResponseBlock<T: Decodable> = (String?, T?) -> Void

struct APIController {

    static func request<T: Decodable>(responseType: T.Type, manager: APIManager, params: Parameters? = nil, completion: @escaping ResponseBlock<T>){
        
        
        Alamofire.request(manager.url, method: manager.method, parameters: params, encoding: manager.encoding, headers: manager.header).validate().responseData { (responseData) in
            
            switch responseData.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(T.self, from: data)
                    completion(nil, result)
                }catch (let error){
                    completion(error.localizedDescription, nil)
                }
                
            case .failure(let error):
                
                completion(error.localizedDescription, nil)
            }
            
        }
    }
}

