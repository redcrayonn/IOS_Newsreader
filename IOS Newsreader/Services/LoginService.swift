//
//  LoginService.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation

class LoginService
{
    let baseService: BaseService = BaseService()
    var loginResult: LoginResult = LoginResult()
    
    public func login(username: String,
                      password: String,
                      onSuccess: @escaping (_ result: LoginResult) -> (),
                      onFailure: @escaping () -> ())
    {
        let headers: [String : String] = [:]
        var parameters: [String : Any] = [:]
        let path: String = "/users/login"
        
        parameters["username"] = username
        parameters["password"] = password
        
        return baseService.send(toRelativePath: path,
                               withHttpMethod: .post,
                               withParameters: parameters,
                               withHeaders: headers,
                               onSuccessParser: { (token) in
                                do {
                                    let result = try JSONDecoder().decode(LoginResult.self, from: token )
                                    if result.authToken == nil {
                                        onFailure()
                                    }
                                    User.currentUser().username = username as String
                                    User.currentUser().authToken = result.authToken
                                    onSuccess(result)
                                }catch{
                                    print("Json parse failed")
                                    onFailure()
                                }
                                
        }, onFailure: {
            print("Request failed")
        })
    }
}
