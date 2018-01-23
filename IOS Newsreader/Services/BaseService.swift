//
//  BaseService.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BaseService {
    let apiBaseUrl: String = "https://inhollandbackend.azurewebsites.net/api"
    
    func getArticles()
    {
        
    }
    
    public func send(toRelativePath url: String,
                     withHttpMethod httpMethod: HTTPMethod,
                     withParameters parameters: [String: Any] = [:],
                     withHeaders headers: [String : String] = [:],
                     withEncoding encoding: ParameterEncoding = URLEncoding.default,
                     onSuccessParser onSuccess: @escaping (_ data: Data) -> (),
                     onFailure: @escaping () -> ()) -> () {
        
        print(apiBaseUrl + url)
        
        Alamofire.request(apiBaseUrl + url,
                          method: httpMethod,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers).response { response in
                            if response.error != nil {
                                print("Error: \(String(describing: response.error))")
                                onFailure()
                            }
                            
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Response data: \(utf8Text)")
                                onSuccess(data)
                            }
        }
    }
}
