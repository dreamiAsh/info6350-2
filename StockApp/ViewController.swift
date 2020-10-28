//
//  ViewController.swift
//  StockApp
//
//  Created by Leng on 10/27/20.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftJSON
import PromiseKit

class ViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getValue(_ sender: Any) {
        
        let url = getURL(<#T##input: UITextField##UITextField#>)
        
        getData(for: url).done{ (price, name) in
            print(price)
            self.txtCEO.text = "\(name)"
            self.txtPrice.text = "\(price)"
        }
        .catch { (error) in
            print(error)
        }
    }
    
    func getData(for url : String) -> Promise<(String)>{
        return Promise<(String)> { seal -> Void in
            AF.request(url).responseJSON{
                response in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                
                let curJSON :JSON = JSON(response.data!)
                
                var price = ""
                var name = ""
                
                print(curJSON["price"])
                print(curJSON["name"])
                price = curJSON["price"].stringValue
                name = curJSON["name"].stringValue
                
                seal.fulfill((price, name))
            }
            
        }
    }
    
    func getURL(_ input : UITextField) -> String{
        var url = "https://financialmodelingprep.com/api/v3/quote/AAPL?apikey=demo"
        url.append("\(input)")
        return url
    }
}

