//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/9/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData(feedDataModel:FeedData){
        
        usernameLbl.text = feedDataModel.userName
        likesLbl.text = String(feedDataModel.likes) + " likes"
        captionLbl.text = feedDataModel.postCaption
        timeLbl.text = feedDataModel.date
        
        
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
    }
}
