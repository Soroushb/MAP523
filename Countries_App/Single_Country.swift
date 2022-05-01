//
//  Single_Country.swift
//  FinalTest_Soroush
//
//  Created by user209730 on 4/19/22.
//

import Foundation

struct Single_Country:Codable{
    
    
    var population:Int = 0;
    
    
    //enum arrayKeys: String, CodingKey{
        
    //    case country="0"
    //}
    
    enum CodingKeys: String, CodingKey{
        
        case population="population"
        
    }
    
    // implementation of the encode() --> Codable protocol
       func encode(to encoder:Encoder) throws {
             // do nothing
       }

       // custom init() --> parameter of type Decoder
       // Data comes back from the API
       // Decoder function will extract the information from the API and map it to the correct properties in the struct
     init(from decoder:Decoder) throws {
         
           // 1. try to take the api response and convert it to data we can use
           let response = try decoder.container(keyedBy: CodingKeys.self)
           
           // 2. extract the relevant keys from that api response
    
         self.population = try response.decodeIfPresent(Int.self, forKey: CodingKeys.population) ?? 0
     }
    
    func display() {
            print("Population: \(population)");
        }
}
