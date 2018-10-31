//
//  AppDetailViewController.swift
//  inclass3
//
//  Created by Ankit Kelkar on 10/31/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var imglarge: UIImageView!
    @IBOutlet weak var developer: UILabel!
      @IBOutlet weak var price: UILabel!
    var name:String = ""
    var dev:String = ""
    var imgurl:String = ""
    var priceVal:String = ""
    var dateval:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
imglarge.downloaded(from: imgurl)
        titleName.text = name
        developer.text = dev
        price.text = priceVal
        date.text = dateval
        // Do any additional setup after loading the view.
    }
    

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
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
