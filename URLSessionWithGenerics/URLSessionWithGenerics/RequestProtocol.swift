//
//  RequestProtocol.swift
//  Generic Structs
//
//  Created by 843832 on 14/10/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
protocol RequestProtocol {
    var url:String?{get}
    var urlRequest:URLRequest?{get}
    var httpMethod:String?{get}
    var requestTimeOut:Double?{get}
    var cachePolicy:NSURLRequest.CachePolicy?{get}
}
protocol ResponseProtocol {
    associatedtype ObjectType
    var responseObject:ObjectType?{
        get set
    }
    var customClass:ObjectType.Type?{get set}
}
