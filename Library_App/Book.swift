//
//  Book.swift
//  a4-Soroush-sbahrami7
//
//  Created by user209730 on 4/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Book:Codable{
    
    
    @DocumentID var id:String?
    
    var title:String = ""
    var author:String = ""
    var borrower:String? = ""
    var availability:String{
        get{
            if(borrower == ""){
                return "available"
            }else{
                return "checked out"
            }
        }
    }
}
