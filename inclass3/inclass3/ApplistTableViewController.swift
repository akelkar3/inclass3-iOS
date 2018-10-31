//
//  ApplistTableViewController.swift
//  inclass3
//
//  Created by Ankit Kelkar on 10/30/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class ApplistTableViewController: UITableViewController {
   
    var selectedCategory:String = ""
    var selectedRow:Int = 0
    var datalist:[(title: String, developer: String, imgSmall: String, imgLarge: String, releaseDate: String, price: String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        datalist = AppsData1.data[selectedCategory]!
        
        //nt the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
  
    
    // MARK: - Table view data source

    


    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datalist.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let data = datalist[indexPath.row]
        self.selectedRow = indexPath.row
          performSegue(withIdentifier: "detailSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue called")
        var data = datalist[self.selectedRow]
        let destination = segue.destination as! AppDetailViewController
        destination.name = data.title
        destination.dev = data.developer
        destination.imgurl = data.imgLarge
        destination.priceVal = data.price
        destination.dateval = getDateInFormat(indate: data.releaseDate)
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appcell", for: indexPath)
            let name:UILabel = cell.viewWithTag(2) as! UILabel
        name.text = datalist[indexPath.row].title
        let dev:UILabel = cell.viewWithTag(3) as! UILabel
        dev.text = datalist[indexPath.row].developer
       
        let date:UILabel = cell.viewWithTag(4) as! UILabel
        date.text = getDateInFormat(indate: datalist[indexPath.row].releaseDate) 
        let price:UILabel = cell.viewWithTag(5) as! UILabel
        price.text = datalist[indexPath.row].price
        let smallimage:UIImageView = cell.viewWithTag(1) as! UIImageView
        smallimage.downloaded(from:  datalist[indexPath.row].imgSmall)
        // Configure the cell...

        return cell
    }
    func getDateInFormat(indate : String) -> String {
        let dateFormatterGet = DateFormatter()
    //    2011-11-17T00:00:00-07:00
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: indate) {
        return dateFormatterPrint.string(from: date)
        } else {
           return "There was an error decoding the string"
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
