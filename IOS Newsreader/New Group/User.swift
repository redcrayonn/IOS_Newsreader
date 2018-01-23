//
//  User.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation

// Singleton user
class User{
    var username: String? = nil
    var authToken: String? = nil
    var isLoggedIn: Bool {
        get {
            return authToken != nil
        }
    }
    
    init() {}
    
    private static var instance: User?
    
    static func currentUser() -> User {
        if instance == nil {
            instance = User()
        }
        return instance!
    }
    
    public static func logOut()
    {
        instance = nil
    }
}
