//
//  User.swift
//  a4-Soroush-sbahrami7
//
//  Created by user209730 on 4/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User:Codable{
    
    
    @DocumentID var id:String?
    
    var username:String = ""
    var password:String = ""
   
}
