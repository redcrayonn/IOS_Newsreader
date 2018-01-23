//
//  DetailViewController.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var summaryText: UITextView!
    @IBOutlet var likeSwitch: UISwitch!
    @IBOutlet var likeLabel: UILabel!
    
    var article: Article?
    var articleService: ArticleService = ArticleService()
    let articleVC: ArticleTableViewController = ArticleTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeSwitch.isHidden = !User.currentUser().isLoggedIn
        likeLabel.isHidden = !User.currentUser().isLoggedIn
        likeSwitch.isOn = (article?.IsLiked)!
        
        titleLabel.text = article?.Title
        summaryText.text = article?.Summary!
        articleService.loadImage(in: self.image, of: article!)
    }
    
    @IBAction func readMoreBtn(_ sender: Any) {
        if let articleUrl = self.article?.Url {
            if let url = URL(string: articleUrl) {
                let application = UIApplication.shared
                application.open(url)
            }
        }
    }
    
    // Like or unlike actions for articles
    /*
    @IBAction func likeSwitchToggle(_ sender: UISwitch) {
        if likeSwitch.isOn{
            articleService.likeArticle(id: (article?.Id)!, onSuccess: {
                self.article?.IsLiked = true
            }, onFailure: {
                print("did not like, something went wrong")
                self.likeSwitch.isOn = false
            })
        } else {
            articleService.unlikeArticle(id: (article?.Id)!, onSuccess: {
                self.article?.IsLiked = false
            }, onFailure: {
                print("did not unlike, something went wrong")
                self.likeSwitch.isOn = true
            })
        }
    }*/
}
