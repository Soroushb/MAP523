//
//  Screen2ViewController.swift
//  a4-Soroush-sbahrami7
//
//  Created by user209730 on 4/7/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class Screen2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //firestore database
    let db = Firestore.firestore()
    var books:[Book] = [];
    var username:String = ""
    var bookToEdit:Book?

    //error label
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var confirmationLbl: UILabel!
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    //each row displayes the title, author, availability and if applicable, the borrower
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let currBook = self.books[indexPath.row]
        cell.textLabel?.text = "\(currBook.title) by \(currBook.author)"
        if(currBook.borrower != ""){
            cell.detailTextLabel?.text = "\(currBook.availability): Currently borrowed by \(currBook.borrower!)"
        }else{
            cell.detailTextLabel?.text = currBook.availability
        }
        return cell;
        
    }
    //tapping on a row borrows a book if currently available
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        bookToEdit = self.books[indexPath.row]
        let bookToAdd = Book(id: bookToEdit!.id, title: bookToEdit!.title, author:bookToEdit!.author, borrower: username)
        
        if(bookToEdit!.availability == "available"){
            
            do{
                try self.db.collection("books").document(self.bookToEdit?.id ?? "N/A").setData(from: bookToAdd);
                confirmationLbl.text = "\(bookToAdd.title) is yours now!"
                confirmationLbl.isHidden = false;
        
            }catch{
                print("error occured when updating the book")
            
            }
            
        }else{
            
            confirmationLbl.text = "\(bookToAdd.title) can't be borrowed!"
            confirmationLbl.textColor = errorLbl.textColor
            confirmationLbl.isHidden = false;
            
        }
        
        
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
 
    return 1
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        
        bookToEdit = self.books[indexPath.row]
        let booktoAdd = Book(id:bookToEdit!.id, title:bookToEdit!.title, author: bookToEdit!.author, borrower: "");

        if(bookToEdit?.borrower == username){
            
            if(errorLbl.isHidden == false){

                errorLbl.text = "Thanks for returning \(bookToEdit!.title)"
                if(confirmationLbl.isHidden == false){
                    confirmationLbl.isHidden = true;
                }
            }
            do{
             try self.db.collection("books").document((self.bookToEdit?.id)!).setData(from: booktoAdd);
        
            }catch{
                print("error occured when updating the book")
            }
        }else{
            errorLbl.isHidden = false;
        }
        
    }

    @IBOutlet weak var myTableView: UITableView!
    
   
    
    
    override func viewDidLoad() {
        
       // getAllData();
        super.viewDidLoad()
        myTableView.delegate = self;
        errorLbl.isHidden = true;
        confirmationLbl.isHidden = true;
        // Do any additional setup after loading the view.
        db.collection("books").getDocuments{
            
            (queryResults, error) in
            if let err = error{
                print("Error retrieving documents from FS")
            }else{
                for document in queryResults!.documents {                    print(document.data())
                    do{
                    let bookFromFireStore = try document.data(as: Book.self)
                        self.books.append(bookFromFireStore!)
                    }catch{
                      print("Error converting document to Book object")
                    }
                }
                print("Done adding books from FS")
                print(self.username)
                self.myTableView.dataSource = self;

            }
        }
    }

}
