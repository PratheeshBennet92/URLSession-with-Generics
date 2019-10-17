//
//  ViewController.swift
//  URLSessionWithGenerics
//
//  Created by Pratheesh on 10/17/19.
//  Copyright © 2019 Pratheesh. All rights reserved.
//

import UIKit
struct Person:Decodable,Encodable {
    var name:String?
    var age:String?
}
struct Fruit:Decodable,Encodable {
    var name:String?
    var price:String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hitPersonAPI()
        self.hitFruitsAPI()
        // Do any additional setup after loading the view.
    }
    func hitPersonAPI() {
        var requestObj = RequestModel()
        requestObj.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        requestObj.requestTimeOut = 60
        requestObj.url = "https://demo6962608.mockable.io/personAPI"
        requestObj.httpMethod = "GET"
        let networkHandler = NetworkHandler<Person>.shared
        networkHandler.requestObject = requestObj
        networkHandler.responseClosure = {(responseObj) in
            print("*******Response Person********",responseObj as Person)
        }
        networkHandler.errorClosure = {(error) in
            print("Person:\(error)")
        }
        networkHandler.downLoadData()
        print("*******Response Person object ********",networkHandler)
        
    }
    
    func hitFruitsAPI(){
        var requestObj = RequestModel()
        requestObj.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        requestObj.requestTimeOut = 60
        requestObj.url = "https://demo6962608.mockable.io/fruits"
        requestObj.httpMethod = "GET"
        let networkHandler = NetworkHandler<Fruit>.shared
        networkHandler.requestObject = requestObj
        networkHandler.responseClosure = {(responseObj) in
            print("*******Response Fruit********",responseObj as Fruit)
        }
        networkHandler.errorClosure = {(error) in
            print("Fruits:\(error)")
        }
        networkHandler.downLoadData()
        print(networkHandler)
        
    }



}

