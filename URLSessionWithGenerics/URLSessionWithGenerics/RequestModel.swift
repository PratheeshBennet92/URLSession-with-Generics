//
//  RequestModel.swift
//  Generic Structs
//
//  Created by 843832 on 14/10/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
/*Generic structs works with any type*/
struct RequestModel:RequestProtocol {
    var defaultTimeOut = 60
    var url:String?
    var httpMethod:String?
    var cachePolicy: NSURLRequest.CachePolicy?
    var requestTimeOut: Double?
    internal var urlRequest: URLRequest?{
        if let urlString = url,  let urlObject = URL(string:urlString){
            return URLRequest(url: urlObject)
        }
        return nil
    }
}
