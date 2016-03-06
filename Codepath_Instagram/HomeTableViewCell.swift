//
//  HomeTableViewCell.swift
//  Codepath_Instagram
//
//  Created by Lilian Ngweta on 3/5/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var homeView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var post: PFObject! {
        
        didSet{
        
             self.captionLabel.text = post["caption"] as! String?
             self.homeView.file = post["media"] as? PFFile
            self.homeView.loadInBackground()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
