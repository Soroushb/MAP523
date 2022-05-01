//
//  ViewController.swift
//  Pizza2_Soroush_sbahrami7
//
//  Created by user209730 on 2/11/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var pizzaTypes = [Pizza]();  //Declaring an array of type Pizza
    var qty:Double = 1.0;
    
    var p1:Pizza = Pizza(pizzaName: "The Original", description: "Pepperoni, cheese, green onions. Served with extra tomato sauce and three types of cheese.", size: "small")
    
    var p2:Pizza = Pizza(pizzaName: "Vegetarian Fiesta Pizza", description: "Roasted red peppers, caramelized onions, sundried organic tomatoes,feta, and spinach, on a thin crust with pesto sauce.", size: "small")
    
    var p3:Pizza = Pizza(pizzaName: "Spicy Pulled Pork Pizza", description: "Slow-roasted pulled pork with a special spicy and smoky BBQ pizza sauce.", size: "small")
    
    var chosenPizza:Pizza = Pizza(pizzaName: "", description: "", size: "");
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var pizzaDescription: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizzaTypes.count;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pizzaTypes[row].pizzaName;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pizzaDescription.text = pizzaTypes[row].description;
        chosenPizza.pizzaName = pizzaTypes[row].pizzaName;
        chosenPizza.description = pizzaTypes[row].description;
        
    }
    
   
    
    @IBAction func orderButtonPressed(_ sender: Any) {
      // var selectedIndex =  self.pickerView.selectedRow(inComponent: 0);
       // pizzaDescription.text = pizzaTypes[selectedIndex].description;
       // chosenPizza.pizzaName = pizzaTypes[selectedIndex].pizzaName;
    
        let box = UIAlertController(title: "Placing an order", message: "Are you sure you are ready to place this order?", preferredStyle: .alert);
        self.present(box, animated: true);
        box.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            guard let screen2 = self.storyboard?.instantiateViewController(identifier: "screen2") as? Screen2ViewController else {
                               print("Cannot find a screen with an id of screen2yellow")
                               return
                   }
             
            print("Screen found, navigating to next screen")
            screen2.chosenPizza = self.chosenPizza;
            screen2.quantity = self.qty;
            self.show(screen2, sender: self)
            
        }));
        box.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil));
                
        
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        pickerView.selectRow(2, inComponent: 0, animated: true)
        pizzaTypes.append(p1);
        pizzaTypes.append(p2);
        pizzaTypes.append(p3);
        pizzaDescription.text = pizzaTypes[0].description;
        stepper.value = 1;
        chosenPizza.pizzaName = pizzaTypes[0].pizzaName;
        chosenPizza.size = "medium";
        
        

    }

    
    
    @IBAction func segmentChanged(_ sender: Any) {
        print(segmentControl.selectedSegmentIndex);
        
        switch(segmentControl.selectedSegmentIndex){
        case 0:
            chosenPizza.size = "small";
            break;
        case 1:
            chosenPizza.size = "medium";
            break;
        case 2:
            chosenPizza.size = "large";
            break;
        default:
            chosenPizza.size = "medium";
        }
        
        print("\(chosenPizza.pizzaName) in \(chosenPizza.size) size");
        
    }
    
    
    @IBAction func stepperChanged(_ sender: Any) {
        print("\(stepper.value)")
        quantity.text = ("Quantity: \(String(Int(stepper.value)))");
        qty = stepper.value;
    }
    
    
    
    @IBAction func startOverPressed(_ sender: Any) {
        
        segmentControl.selectedSegmentIndex = 1;
        pickerView.selectRow(0, inComponent: 0, animated: true);
        stepper.value = 1.0
        pizzaDescription.text = pizzaTypes[0].description;
        
    }
    
    

}

