//
//  FeedVC.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/8/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var FeedTableView: UITableView!
   var feedDataArray:[FeedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedTableView.delegate = self
        FeedTableView.dataSource = self
        FeedTableView.separatorStyle = .none
          FeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        topBarView.layer.masksToBounds = false
        topBarView.layer.shadowRadius = 1
        topBarView.layer.shadowOpacity = 0.4
       topBarView.layer.shadowColor = UIColor.gray.cgColor
        topBarView.layer.shadowOffset = CGSize(width: 0 , height:1)
        
        getDataFromFirestore()
        
    }
    
   func  getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
    fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
        
        if error != nil{
            print(error?.localizedDescription)
        }else{
            
            if snapshot?.isEmpty != true && snapshot != nil {
                
                
                self.feedDataArray.removeAll()
                
                for document in snapshot!.documents{
                    
                     
                    let FeedFirestoreData = FeedData(userName: document.get("postedBy") as! String, likes: document.get("likes") as! Int, postCaption: document.get("postCaption") as! String
                        , imageUrl: document.get("imageUrl") as! String, date: document.get("date") as? String ?? "",documentID: document.documentID, likedPost: document.get("likedPost") as? Bool ?? false)
                    
                    self.feedDataArray.append(FeedFirestoreData)
                  
                    print("DATe", document.get("date") as? String)
                                        
                    
                }
                
                self.FeedTableView.reloadData()
            }
            
        }
        
    }
    
        
        
    }


}

extension FeedVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.setData(feedDataModel: feedDataArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    
    
    
}
