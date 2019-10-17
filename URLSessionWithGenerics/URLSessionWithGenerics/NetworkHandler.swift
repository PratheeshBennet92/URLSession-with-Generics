//
//  NetworkHandler.swift
//  Generic Structs
//
//  Created by 843832 on 14/10/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
class NetworkHandler<Element>:NSObject,URLSessionDelegate,URLSessionDataDelegate where Element:Encodable, Element:Decodable {
    static var shared:NetworkHandler<Element>{
        return NetworkHandler<Element>()
    }
    typealias ResponseClosure = (Element) -> Void
    typealias ErrorClosure = (Error) -> Void
    var responseClosure:ResponseClosure?
    var errorClosure:ErrorClosure?
    typealias ResponseObjectType = Element
    var requestObject:RequestModel?
    var requestModel:RequestModel?
    var configuration:URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "bgTask \(String(describing: Element.self))")
        sessionConfig.isDiscretionary = true
        sessionConfig.allowsCellularAccess = true
        return sessionConfig
    }
    private var urlSession:URLSession {
        return URLSession(configuration:configuration, delegate:self, delegateQueue: OperationQueue.main)
    }
    
    func getSession() -> URLSession {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: "bgTask \(String(describing: Element.self))")
        sessionConfig.isDiscretionary = true
        sessionConfig.allowsCellularAccess = true
        return urlSession
    }
    func downLoadData(){
        guard var request = requestObject?.urlRequest
        else {
        return
        }
        request.httpMethod = requestObject?.httpMethod
        request.timeoutInterval = requestObject?.requestTimeOut ?? TimeInterval((requestObject?.defaultTimeOut)!)
        request.cachePolicy = (requestObject?.cachePolicy)!
        let task = getSession().dataTask(with: request)
        task.taskDescription = String(describing: Element.self)
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(session)
        print(task.taskDescription ?? "")
        if error != nil{
            errorClosure?(error!)
        }
    }
  
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        do {
            if let jsonString = String(data: data, encoding: .utf8){
                print(jsonString)
                let jsonData = jsonString.data(using: .utf8)!
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                decoder.dataDecodingStrategy = .base64
                let responseObject = try decoder.decode(ResponseObjectType.self, from: jsonData)
                print("********************* self \(self)")
                if responseClosure != nil{
                    responseClosure!(responseObject)
                }
            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
}
