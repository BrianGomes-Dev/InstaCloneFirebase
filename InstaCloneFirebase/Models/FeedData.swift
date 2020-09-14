//
//  FeedData.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/13/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import Foundation
import Firebase

class FeedData: NSObject {
   var userName:String!
   var likes:Int!
   var postCaption:String!
    var imageUrl:String!
    var date:String!
    
    
    init(userName:String, likes:Int,postCaption:String,imageUrl:String,date:String)
    {
        super.init()
        self.userName = userName
        self.likes = likes
        self.postCaption = postCaption
        self.imageUrl = imageUrl
        self.date = formatBookingTime(ts: date)
    }
    
    
    func formatBookingTime(ts: String) -> String{
          let doubleTs = Double(ts) ?? 0.0
          let timestmp = doubleTs/1000
          let date = Date(timeIntervalSince1970: timestmp)
          let df = DateFormatter()
          df.dateFormat = "EEE, dd MMM yyyy - h:mm a"
          let dt = df.string(from: date)
          return dt
      }
    
}
