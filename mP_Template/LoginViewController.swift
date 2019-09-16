//
//  LoginViewController.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 7/24/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var userID1: UILabel!
    var pickList = UIPickerView()
    var userMap = [Int:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickList.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(LoginViewController.cancelBtnClicked(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(LoginViewController.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.blue
        cancelButton.tintColor = UIColor.black
        toolBar.isUserInteractionEnabled = true
        toolBar.items = [cancelButton,spaceButton,doneButton]
        userField.inputView = pickList
        userField.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
    }
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        userField?.text = ""
        userField?.resignFirstResponder()
        Utility.currentUser = -1
    }
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        var row = self.pickList.selectedRow(inComponent: 0);
        NSLog("value L %d", row)
        pickerView(self.pickList, didSelectRow: row, inComponent:0)
        Utility.currentUser = row
        //populateUserInfo()
        userField?.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utility.userMap.count
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userField.text = (Utility.userMap[row]?["$FirstName"])! + " " + (Utility.userMap[row]?["$LastName"])!
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (Utility.userMap[row]?["$FirstName"])! + " " + (Utility.userMap[row]?["$LastName"])!
    }
    
    
    @IBAction func returnToMain(_ sender: UIButton) {
        
        if(Utility.currentUser == -1){
            self.dismiss(animated: true, completion: nil)
            return

        }
        var currentUser = MParticle.sharedInstance().identity.currentUser
        let identityRequest = MPIdentityApiRequest(user: currentUser!)
        identityRequest.email = Utility.userMap[Utility.currentUser]!["email"]
        NSLog("email set to: " + Utility.userMap[Utility.currentUser]!["email"]!)
        identityRequest.customerId = Utility.userMap[Utility.currentUser]!["customerid"]
        NSLog("customerid set to: " + Utility.userMap[Utility.currentUser]!["customerid"]!)
        for userID in (Utility.userMap[Utility.currentUser]?.keys)!{
            NSLog("user key: " + userID)
            if(userID == "email" || userID == "customerid"){
                continue
            }
            if(Utility.userIDMap.keys.contains(userID) && !userID.contains("$")){
                NSLog("ID called: value is " + Utility.userMap[Utility.currentUser]![userID]! + " and type is ")
                identityRequest.setUserIdentity(Utility.userMap[Utility.currentUser]![userID], identityType: setUserIdentity(id: userID))
                
            }
            else{
                NSLog("Att " + userID + " called with value: " + Utility.userMap[Utility.currentUser]![userID]!)
                currentUser?.setUserAttribute(userID, value: Utility.userMap[Utility.currentUser]![userID])
            }
        }
        let idreq2 = identityRequest
        NSLog("Current ID req: " + identityRequest.email!)
        MParticle.sharedInstance().identity.login(identityRequest, completion: {(apiResult, error) -> Void in
            if((error) != nil){
                
            }
            else{
                currentUser = apiResult?.user
            }
            
            
        })
        
        MParticle.sharedInstance().identity.modify(idreq2, completion: nil)
        Utility.loginStatus = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserIdentity (id: String) -> MPUserIdentity{
        
        switch id {
        case "facebook" :
            NSLog("returning " + id)
            return MPUserIdentity.facebook
        case "twitter" :
            NSLog("returning " + id)
            return MPUserIdentity.twitter
        case "facebookcustomaudienceid" :
            NSLog("returning " + id)
            return MPUserIdentity.facebookCustomAudienceId
        case "google" :
            NSLog("returning " + id)
            return MPUserIdentity.google
        case "microsoft" :
            NSLog("returning " + id)
            return MPUserIdentity.microsoft
        case "yahoo" :
            NSLog("returning " + id)
            return MPUserIdentity.yahoo
        default :
            NSLog("returning (other) " + id)
            return MPUserIdentity.other
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
