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

    @IBOutlet weak var FeedTableView: UITableView!
   var feedDataArray:[FeedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedTableView.delegate = self
        FeedTableView.dataSource = self
        FeedTableView.separatorStyle = .none
          FeedTableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedCell")
        
        getDataFromFirestore()
        
    }
    
   func  getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
    fireStoreDatabase.collection("Posts").addSnapshotListener { (snapshot, error) in
        
        if error != nil{
            print(error?.localizedDescription)
        }else{
            
            if snapshot?.isEmpty != true && snapshot != nil {
                
                for document in snapshot!.documents{
                    let FeedFirestoreData = FeedData(userName: document.get("postedBy") as! String, likes: document.get("likes") as! Int, postCaption: document.get("postCaption") as! String
                        , imageUrl: document.get("imageUrl") as! String, date: document.get("date") as? String ?? "")
                    
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
        return 400
    }
    
    
    
    
}
