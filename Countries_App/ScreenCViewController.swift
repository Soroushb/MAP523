//
//  ScreenCViewController.swift
//  FinalTest_Soroush
//
//  Created by user209730 on 4/18/22.
//

import UIKit
import CoreData

class ScreenCViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var favList:[Favorite] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    

    var population:Int = 0;
    @IBOutlet weak var myTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        getCanada()        // Do any additional setup after loading the view.
        //fetchAll()
       // myTableView.reloadData()
        myTableView.delegate = self
        //myTableView.dataSource = self
        //print(favList)
        //print(population)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = "Country Name: \(favList[indexPath.row].name!)"
            
        cell.detailTextLabel!.text = "Population: \(String(Int32(favList[indexPath.row].population)))"
        
        print(population)
        if(favList[indexPath.row].population > population ){
            
            cell.backgroundColor = UIColor.yellow
        }
       // if(favList[indexPath.row].population )
     
            return cell
        }

    override func viewWillAppear(_ animated: Bool) {
            // when the app loads, fetch any tasks from CoreData
            // 1. Create a fetchRequest (SELECT  from sql)
        let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
            // predicate (NSPredicate)
            // 2. Execute the fetchRequest
            do {
                let results:[Favorite] = try self.context.fetch(request)
                print("Success when fetching tasks")
                
                // 3. Check if there were any matching results
                print("Number of results from database: \(results.count)")
                
                // 4. If so, do something with those results
                // - In this app, set the tableView's data source to be this list of task objects
                // - Then, refresh the tableview to display the results
                self.favList = results
                
                // force the tableview to update
                self.myTableView.reloadData()
            } catch {
                print("Fetching Tasks failed")
            }
        }

    func fetchAll(){
        
        let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do{
            
            let results:[Favorite] = try self.context.fetch(request)
            favList = results
            
        }catch{
            print("Error occured.")
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // TODO
        return 1
        }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == UITableViewCell.EditingStyle.delete) {
                
                let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
                do{
                    let results:[Favorite] = try self.context.fetch(request)
                    self.context.delete(results[indexPath.row])
                    try self.context.save()
                    //myTableView.reloadData()
                    
                }catch{
                    print("Error finding the country")
                }
            }
        }
    

    
    func getCanada(){
        
        let apiEndPoint = "https://restcountries.com/v3.1/name/Canada"
        
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
                    
                   print(jsonData)
                    
                    do{
                        
                    let decoder = JSONDecoder();
                        
                        let decodedItem:[Single_Country] = try decoder.decode([Single_Country].self, from: jsonData)
                        
                        print(decodedItem)
                        
                        DispatchQueue.main.async {
                        self.population = decodedItem[0].population;
                           // print(self.population)
                           // self.myTableView.delegate = self
                            self.myTableView.dataSource = self
                            self.myTableView.reloadData()
                        }
                          
                       
                    }
                    catch let error{
                        print("Error occured.")
                        print(error)
                       
                    }
                
                }
     
       }.resume()
             

    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
