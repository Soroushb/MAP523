//
//  ViewController.swift
//  a4-Soroush-sbahrami7
//
//  Created by user209730 on 4/7/22.
//

import UIKit
import FirebaseFirestore


class ViewController: UIViewController {

    
    //outlets
    
    @IBOutlet weak var lblUsername: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    //firestore database
    let db = Firestore.firestore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // addUsers(username: "psmith", password: "1234")
       // addUsers(username: "tbrown", password: "0000")
       //addbooks(title: "Dubliners", author: "James Joyce", username: "")
       //addbooks(title: "The Illiad", author: "Homer", username: "psmith")
       //addbooks(title: "Lincoln", author: "Gore Vidal", username: "tbrown")
       //addbooks(title: "Brave New World", author: "Aldous Huxley", username: "tbrown")
       // addbooks(title: "The Sun Also Rises", author: "Ernest Hemingway", username: "")
        //addbooks(title: "The Alchemist", author: "Paulo Coelho", username: "psmith")
        //addbooks(title: "Pnin", author: "Vladimir Nabokov", username: "tbrown")
        // Do any additional setup after loading the view.
        lblError.isHidden = true;
    }
    
    
    //When the user clicks on the login button
    @IBAction func loginPressed(_ sender: Any) {
        
        let username = lblUsername.text!;
        let password = lblPassword.text!;
        //declaring a flag to decide whether or not the error label must be hidden
        var flag:Bool = false;
        //get users from the database
        db.collection("users").getDocuments {
                            (query, error) in
                            
                            // error validation
                            if let error = error {
                                print("Error occured while retrieving documents")
                                print(error)
                                return
                    }
                   
                    for document in query!.documents {
                        print("Document id: \(document.documentID)")
                        print("Document data: \(document.data())")
                        
                        // try to convert the "document.data()" into a instance of a Movie struct
                        // In swift the do-catch is the equivalent of the try-catch in other programming languages
                        do {
                            //testing..
                            let userFromFirestore = try document.data(as:User.self)
                            print("User id: \(userFromFirestore?.id ?? "N/A")")
                            print("Username: \(userFromFirestore?.username ?? "N/A") ")
                            print("Password: \(userFromFirestore?.password ?? "N/A")")
                            //checking the credentials
                            if(username == userFromFirestore?.username && password == userFromFirestore?.password){
                                flag = true;
                            }
                          
                        
                        } catch {
                            print("Error converting document to a User")
                        }
                    }
            //testing
            //print(username)
            //print(password)
            if(flag == true){
                print("Yay")
                if(self.lblError.isHidden == false){
                    self.lblError.isHidden = true;
                   
                }
                
                guard let screen2 = self.storyboard?.instantiateViewController(identifier: "screen2") as? Screen2ViewController else {
                                   print("Cannot find a screen with an id of screen2")
                                   return
                       }
                 
                        //print("Screen found, navigating to next screen")
                //sending the username to the second screen
                screen2.username = self.lblUsername.text ?? "N/A";
                        
                self.navigationController?.pushViewController(screen2, animated: true)            }else{
                self.lblError.isHidden = false;
            }
            
        }
        
    }
    
    //function to add users to the database
    private func addUsers(username:String, password:String) {
          // write the code to add the provided data to firestore
          
          // 1. tell firestore which collection you want to write data to
          // 2. Specify the document you want to insert into the collection
          // 3. Wait for FB to insert the doc, and tell you the results
          
          // 1. create a dictionary that represents the data we want to insert
          let user1ToInsert = ["username":username, "password":password]
          // 2. insert it into firestore
          do {
              try db.collection("users").addDocument(data: user1ToInsert)
              print("Document Saved!")
          } catch {
              print("Error when saving document")
              print(error)
          }
        
}

    //function to add books to the database
    private func addbooks(title:String, author:String, username:String?) {
          // write the code to add the provided data to firestore
          
          // 1. tell firestore which collection you want to write data to
          // 2. Specify the document you want to insert into the collection
          // 3. Wait for FB to insert the doc, and tell you the results
          
          // 1. create a dictionary that represents the data we want to insert
        let bookToInsert = ["title":title, "author":author, "borrower":username ?? ""]
          // 2. insert it into firestore
          do {
              try db.collection("books").addDocument(data: bookToInsert)
              print("Document Saved!")
          } catch {
              print("Error when saving document")
              print(error)
          }
        
}
}
