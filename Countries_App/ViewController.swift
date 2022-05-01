//
//  ViewController.swift
//  FinalTest_Soroush
//
//  Created by user209730 on 4/15/22.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var countryArray:[Country] = [];
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCountries()
    
      
        myTableView.dataSource = self
        myTableView.delegate = self
        
        //print(myArray)

    }
    
    
    func getCountries(){
        
        
            let apiEndPoint = "https://restcountries.com/v2/all"
            
            guard let url = URL(string:apiEndPoint) else {
                print("failed to convert.")
                return;
            }
        
            
        URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if let err = error{
                    print("Error occured fetching data.")
                    print(err)
                    return
                }
                
                if let jsonData = data{
                    
                   // print(jsonData)
                    
                    do{
                        
                    let decoder = JSONDecoder();
                        
                        let decodedItem:[Country] = try decoder.decode([Country].self, from: jsonData)
                        
                        //print(decodedItem)
                        
                        DispatchQueue.main.async {
                         
                        for i in 0 ..< (decodedItem.count - 1){
                            
                           
                            self.countryArray.append(decodedItem[i])
                         
                           
                        }
                            
                            self.myTableView.reloadData()
                        }
                        
        
                       
                    }
                    catch let error{
                        print("Error occured.")
                        print(error)
                       
                    }
                
                }
     
       }.resume()
             

    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for:indexPath)
                //  debug
        cell.textLabel!.text = countryArray[indexPath.row].countryName;
        //print(countryArray)
                return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
        //return 5
    }
    
    
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //  print("User clicked on row #\(indexPath.row), Data is: \(countryNameArray[indexPath.row])")
       
       
       guard let nextScreen = storyboard?.instantiateViewController(identifier: "ScreenB") as? ScreenBViewController else {
                  print("Cannot find next screen")
                  return
              }
              
              nextScreen.ChosenCountry = countryArray[indexPath.row];
              // - navigate to the next screen
              self.navigationController?.pushViewController(nextScreen, animated: true)

       }

    
    func numberOfSections(in tableView: UITableView) -> Int {
            // TODO
        return 1
        }

}

