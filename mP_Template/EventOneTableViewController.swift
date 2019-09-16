//
//  EventOneTableViewController.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 7/25/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK
class EventOneTableViewController: UITableViewController {
    var items = Utility.event1
    override func viewDidLoad() {
        super.viewDidLoad()
        MParticle.sharedInstance().logScreen(Utility.overallEvent1, eventInfo: Utility.overallEvent1Screen)
        MParticle.sharedInstance().upload()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationItem.title = Utility.overallEvent1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = items[indexPath.row]
        
         return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch Utility.event1TrackingTypeMap[indexPath.row] {
        case "Event" :
            generateEvent(position: indexPath.row)
        case "Ecommerce" :
            generateEcommerceEvent(position: indexPath.row)
        case "Screen" :
            generateScreenEvent(position: indexPath.row)
        case "Error" :
            generateError(position: indexPath.row)
        default:
            NSLog("default")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func showAlert(eventName: String, title: Int) {
        
        let message = eventName
        
        let alertVC = UIAlertController.init(title: Utility.event1AlertTitle[title], message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertVC.addAction(OKAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func generateEvent(position: Int){
        
        var message = String()
        if(!Utility.genericMessageEvent1){
            message = Utility.event1MessageMap[position]!
            
        }
        else{
            message = items[position] + " Selected"
        }
        var eventNames = [] as [String]
        if(!Utility.differentEvent1Names){
            eventNames = Utility.event1
        }
        else{
            eventNames = Utility.event1Names
        }
        let event = MPEvent.init(name: eventNames[position], type: Utility.event1TypeMap[position]!)
        event?.info = Utility.event1Info[position]
        
        MParticle.sharedInstance().logEvent(event!)
        MParticle.sharedInstance().upload()
        showAlert(eventName: message, title: position)
        
    }
    
    func generateEcommerceEvent(position: Int){
        var message = String()
        if(!Utility.genericMessageEvent1){
            message = Utility.event1MessageMap[position]!
            
        }
        else{
            message = items[position] + " Selected"
        }
        let prodName = Utility.event1EcommProdInfo[position]!["Product"] as! String
        let prodSKU = Utility.event1EcommProdInfo[position]!["SKU"] as! String
        let prodQ = Utility.event1EcommProdInfo[position]!["Quantity"] as! NSNumber
        let prodPrice = Utility.event1EcommProdInfo[position]!["Price"] as! NSNumber
        let prod = MPProduct.init(name: prodName, sku: prodSKU, quantity: prodQ, price: prodPrice)
        let commActionRawValue = Utility.commActionMap[Utility.event1EcommActionInfo[position]!]
        let transactionID = Utility.event1EcommAttInfo[position]!["Transaction ID"] as! String
        let revenue = Utility.event1EcommAttInfo[position]!["Revenue"] as! NSNumber
        let tax = Utility.event1EcommAttInfo[position]!["Tax"] as! NSNumber
        let shipping = Utility.event1EcommAttInfo[position]!["Shipping"] as! NSNumber
        let ecommAtt = MPTransactionAttributes.init()
        ecommAtt.transactionId = transactionID
        ecommAtt.revenue = revenue
        ecommAtt.tax = tax
        ecommAtt.shipping = shipping
        
        let action = MPCommerceEventAction (rawValue: commActionRawValue!)
        
        let comT = MPCommerceEvent.init()
        comT.addProduct(prod)
        comT.action = action!
        comT.transactionAttributes = ecommAtt
        if(Utility.event1EcommCustomAttInfo[position] != nil){
            comT.setCustomAttributes(Utility.event1EcommCustomAttInfo[position] as! [String : String])
        }
        MParticle.sharedInstance().logCommerceEvent(comT)
        showAlert(eventName: message, title: position)
    }
    
    func generateError(position: Int){
        var message = String()
        if(!Utility.genericMessageEvent1){
            message = Utility.event1MessageMap[position]!
            
        }
        else{
            message = items[position] + " Selected"
        }
        MParticle.sharedInstance().logError(Utility.event1MessageMap[position]!, eventInfo: Utility.event1ErrorReason[position]!)
        MParticle.sharedInstance().upload()
        showAlert(eventName: message, title: position)
    }
    
    func generateScreenEvent (position: Int){
        var message = String()
        if(!Utility.genericMessageEvent1){
            message = Utility.event1MessageMap[position]!
            
        }
        else{
            message = items[position] + " Selected"
        }
        
        let screenName = Utility.event1ScreenInfoMap[position]!["Name"] as! String
        let screenInfo = Utility.event1ScreenInfoMap[position]!["Info"] as! [String:Any]?
        MParticle.sharedInstance().logScreen(screenName, eventInfo: screenInfo)
        MParticle.sharedInstance().upload()
        showAlert(eventName: message, title: position)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
