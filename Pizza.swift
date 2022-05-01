//
//  Pizza.swift
//  Pizza2_Soroush_sbahrami7
//
//  Created by user209730 on 2/13/22.
//

import Foundation
import Darwin

class Pizza{
    
    var pizzaName:String;
    var description:String;
    var size:String;
    
    init(pizzaName:String, description:String, size:String){
           self.pizzaName = pizzaName;
           self.description = description;
           self.size = size;
           
       }
    
    func display() {
            print("pizza name: \(pizzaName), Description: \(description) size: \(size)");
        }
}
