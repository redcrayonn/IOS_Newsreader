//
//  ArticleTableViewCell.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 22/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    //Mark: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
