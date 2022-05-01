//
//  Screen2ViewController.swift
//  Pizza2_Soroush_sbahrami7
//
//  Created by user209730 on 2/14/22.
//

import UIKit

class Screen2ViewController: UIViewController {

    var quantity:Double = 0.0;
    var price:Double = 0.0;
    var subTotal:Double = 0.0;
    var finalPrice:Double = 0.0;
    var tax:Double = 0.0;
    var chosenPizza = Pizza(pizzaName: "", description: "", size: "");
    
    @IBOutlet weak var mySubTotal: UILabel!
    @IBOutlet weak var myPizzaSize: UILabel!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(chosenPizza.pizzaName) in size \(chosenPizza.size). Quantity: \(Int(quantity))" )
        
        switch(chosenPizza.size){
        case "small":
            price = 15.50;
            break;
        case "medium":
            price = 17.50;
            break;
        case "large":
            price = 21.50
            break;
        default:
            price = 0.0;
        }
        
        subTotal = price * quantity;
        tax = subTotal * 0.13;
        finalPrice = subTotal + tax;
        
       pizzaNameLabel.text = chosenPizza.pizzaName;
       myPizzaSize.text = "Size: \(chosenPizza.size)";
       quantityLabel.text = "Quantity: \(Int(quantity))";
       mySubTotal.text = "Subtotal \(subTotal)";
        taxLabel.text = "Tax: \(tax)";
        finalPriceLabel.text = "Final Price: \(finalPrice)";
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
