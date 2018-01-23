//
//  LoginResult.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation

public class LoginResult : Decodable {
    public var authToken : String?
    
    enum CodingKeys : String, CodingKey {
        case authToken = "AuthToken"
    }
}
