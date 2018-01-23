//
//  Article.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 22/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation
import UIKit


public class Article: Decodable {
    var Id : Int?
    var Feed : Int?
    var Title : String?
    var Summary : String?
    var PublishDate : String?
    var Image : String?
    var Url : String?
    var Related : [String]?
    var Categories : [Category]?
    var IsLiked : Bool?
    
    enum CodingKeys: String, CodingKey{
        case Id = "Id"
        case Feed = "Feed"
        case Title = "Title"
        case Summary = "Summary"
        case PublishDate = "PublishDate"
        case Image = "Image"
        case Url = "Url"
        case Related = "Related"
        case Categories = "Categories"
        case IsLiked = "IsLiked"
    }
}

/*class Article {
    var Id : Int?
    var Feed : Int?
    var Title : String?
    var Summary : String?
    var PublishDate : String?
    var Image : String?
    var Url : String?
    var Related : [String]?
    //var Categories : [Categories]?
    var IsLiked : Bool?
    
    var photo:UIImage?
    
    init(Title: String, photo: UIImage?) {
        self.Title = Title
        self.photo = photo
    }
}*/
