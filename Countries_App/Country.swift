//
//  Country.swift
//  FinalTest_Soroush
//
//  Created by user209730 on 4/15/22.
//

import Foundation

struct Country:Codable{
    
    var countryName:String = "";
    var capital:String = "";
    var countryCode:String = "";
    var population:Int = 0;
    
    
    //enum arrayKeys: String, CodingKey{
        
    //    case country="0"
    //}
    
    enum CodingKeys: String, CodingKey{
        
        case countryName="name"
        case capital="capital"
        case countryCode="alpha3Code"
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
        
         self.countryName = try response.decodeIfPresent(String.self, forKey: CodingKeys.countryName) ?? ""
        
         self.capital = try response.decodeIfPresent(String.self, forKey: CodingKeys.capital) ?? ""
         
         self.countryCode = try response.decodeIfPresent(String.self, forKey: CodingKeys.countryCode) ?? ""
    
         self.population = try response.decodeIfPresent(Int.self, forKey: CodingKeys.population) ?? 0
     }
    
    func display() {
            print("Name: \(countryName), capital: \(capital), code: \(countryCode) population: \(population)");
        }
}
