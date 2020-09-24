//
//  UploadVC.swift
//  InstaCloneFirebase
//
//  Created by user172197 on 9/8/20.
//  Copyright © 2020 Brian Gomes. All rights reserved.
//

import UIKit
import Firebase

class UploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var UploadImageView: UIImageView!
    @IBOutlet weak var commentTextFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        UploadImageView.addGestureRecognizer(gestureRecognizer)
        commentTextFeild.delegate = self
    }
    
    @IBAction func UploadClicked(_ sender: Any) {
        //FireBase Image Upload Functionality
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        let TimeStamp = Date().timeIntervalSince1970 * 1000
        
        if let data = UploadImageView.image?.jpegData(compressionQuality: 0.4){
        
            let uuid = UUID().uuidString
            
        let imageReference = mediaFolder.child(uuid+".jpg")
        imageReference.putData(data, metadata: nil) { (metaData, error) in
            
            if error != nil{
                self.makeAlert(titleInput: "Alert!", messageInput: "Error while Uploading Image.")
            }else{
                imageReference.downloadURL { (url, error) in
                    
                    if error == nil{
                        let imageUrl = url?.absoluteString
                        print(imageUrl)
                        self.makeAlert(titleInput: "Alert", messageInput: "Image Upload Success!")
                        
                        //FireStore Database
                        
                        let firestoreDatabase = Firestore.firestore()
                        
                        var firestoreReference : DocumentReference? = nil
                        
                        let firestorePost = ["imageUrl":imageUrl!,"postedBy":Auth.auth().currentUser!.email,"postCaption":self.commentTextFeild.text!,"date": String(TimeStamp),"likedPost":false,"likes":0 ] as [String : Any]
                        
                        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost,completion: { (error) in
                            
                            if error != nil{
                                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "")
                            
                            }else{
                                self.commentTextFeild.text = ""
                                self.UploadImageView.image = #imageLiteral(resourceName: "add")
                                self.tabBarController?.selectedIndex = 0
                            }
                            
                        })
                        
                        print("timestamp:",TimeStamp)
                        
                    }
                    
                }
            }
            
        }
        }
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        UploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput:String,messageInput:String){
         let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
         
         let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
         alert.addAction(okButton)
         
         self.present(alert,animated: true,completion: nil)
         
         
     }
     
    

}

extension UploadVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // commentTextFeild.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
}
