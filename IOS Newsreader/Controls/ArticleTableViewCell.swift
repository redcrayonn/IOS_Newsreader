//
//  ArticleTableViewCell.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 22/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    let articleService: ArticleService = ArticleService()
    
    //Mark: Properties
    public var article: Article?
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func mapTo(with article: Article) {
        self.article = article
        
        articleTitle.text = self.article!.Title
        articleService.loadImage(in: self.articleImage, of: article)
        //favoriteImage.isHidden = !article.IsLiked!
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
