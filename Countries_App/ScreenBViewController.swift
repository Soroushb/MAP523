//
//  ScreenBViewController.swift
//  FinalTest_Soroush
//
//  Created by user209730 on 4/18/22.
//

import UIKit
import CoreData



class ScreenBViewController: UIViewController {

    
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var capitalLbl: UILabel!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var btnPressed: UIButton!
    
    var ChosenCountry:Country?
    var populationString:String = ""
    var isNil:Bool = true;
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populationString = String(ChosenCountry?.population ?? 0)
        
        if let a = ChosenCountry{
            
            countryNameLbl.text = ChosenCountry?.countryName;
            capitalLbl.text = ChosenCountry?.capital
            codeLbl.text = ChosenCountry?.countryCode
            populationLbl.text = populationString
            isNil = false;
            
            
        }
        
        if(!isNil){
            errorLbl.isHidden = true;
        }

        // Do any additional setup after loading the view.
        
    }
    
    
    
    @IBAction func btnPressed(_ sender: Any) {
        
        addFavorite()
        
    }
    
    func addFavorite(){
        
        let f1 = Favorite(context: self.context)
        
        f1.name = ChosenCountry?.countryName;
        f1.population = Int32(ChosenCountry?.population ?? 0);
        
        do{
        try self.context.save()
           // print("favorite saved")
            let box = UIAlertController(title: "Add Favorites", message: "Saved Successfully!", preferredStyle: .alert)
            box.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(box, animated: true)
        }catch{
            
            let box = UIAlertController(title: "Add Favorites", message: "Failed to Save", preferredStyle: .alert)
            box.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(box, animated: true)
        }
    }
    
    /*0
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
