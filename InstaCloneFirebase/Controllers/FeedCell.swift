//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/9/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var postDocumentID = ""
    var postLikes = 0
    var postLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setData(feedDataModel:FeedData){
        let url = URL(string: feedDataModel.imageUrl)
        self.postImageView.kf.setImage(with: url)
        
       
        likesLbl.text = String(feedDataModel.likes) + " likes"
        captionLbl.text = feedDataModel.postCaption
        timeLbl.text = feedDataModel.date
        postDocumentID = feedDataModel.documentID
        postLikes = feedDataModel.likes
        postLiked = feedDataModel.likedPost
        
        if postLiked{
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
           likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        //Remove characters after @ Symbol for username
        
        let word = feedDataModel.userName
        if let index = word?.range(of: "@")?.lowerBound {
            let substring = word?[..<index] ?? ""                 // "ora"
            // or  let substring = word.prefix(upTo: index) // "ora"
            // (see picture below) Using the prefix(upTo:) method is equivalent to using a partial half-open range as the collection’s subscript.
            // The subscript notation is preferred over prefix(upTo:).

            let formattedUsername = String(substring)
           
             usernameLbl.text = formattedUsername
        }
        
        
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        print("Like Tapped")
        print("DOC ID",postDocumentID)
        
        let fireStoreDatabase = Firestore.firestore()
        
        
        if postLiked{
            
            do{
                let likeStore = ["likes":postLikes - 1,"likedPost":false] as [String:Any]
                
                try fireStoreDatabase.collection("Posts").document(postDocumentID).setData(likeStore, merge: true)
            }catch{
                print(error.localizedDescription)
            }
            
        }else{
            
            do{
                let likeStore = ["likes":postLikes + 1,"likedPost":true] as [String:Any]
                
                try fireStoreDatabase.collection("Posts").document(postDocumentID).setData(likeStore, merge: true)
            }catch{
                print(error.localizedDescription)
            }
        }
        
        
    }
}
