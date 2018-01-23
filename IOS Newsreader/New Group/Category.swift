//
//  Category.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation

public class Category : Decodable {
    public var id : Int?
    public var name : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
