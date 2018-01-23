//
//  Article.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import Foundation
import UIKit

class ArticleService{
    
    let baseService: BaseService = BaseService();
    var articleResult: ArticleResult = ArticleResult()
    
    public func getArticles(nextId: Int?,
                            onSuccess: @escaping (_ result: ArticleResult) -> (),
                            onFailure: @escaping () -> ()) {
        var headers: [String : String] = [:]
        var parameters: [String : Any] = [:]
        var path: String = "/articles"
        
        if User.currentUser().isLoggedIn{
            headers = ["x-authtoken": User.currentUser().authToken!]
        }
        if nextId != nil {
            path += "/\(nextId!)"
            parameters["count"] = 20
        }
        
        return baseService.send(toRelativePath: path,
                               withHttpMethod: .get,
                               withParameters: parameters,
                               withHeaders: headers,
                               onSuccessParser: { (results) in
                                do {
                                    let result = try JSONDecoder().decode(ArticleResult.self, from: results)
                                    self.articleResult = result
                                    onSuccess(self.articleResult)
                                }catch{
                                    print("json failed somehow")
                                }
                                
        }, onFailure: {
            print("failed to do the request")
        })
    }
    
    
    public func loadImage(in articleImage: UIImageView, of article: Article ) {
        let imageView = articleImage
        if let url  = URL(string: article.Image!) {
            let session = URLSession.shared
            
            session.dataTask(with: url,
                             completionHandler: {(optData: Data?,
                                response: URLResponse?,
                                error: Error?) -> () in
                                if let data = optData{
                                    let image = UIImage(data: data)
                                    
                                    DispatchQueue.main.async {
                                        imageView.image = image
                                    }
                                }
            }).resume()
        }
        
    }
}
