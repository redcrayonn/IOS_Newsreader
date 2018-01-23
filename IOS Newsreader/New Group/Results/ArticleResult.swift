//
//  ArticleResult.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation

class ArticleResult: Decodable{
    
    public var articleResults: Array<Article>?
    public var nextId: Int?
    
    enum CodingKeys: String, CodingKey{
        case articleResults = "Results"
        case nextId = "NextId"
    }
}
