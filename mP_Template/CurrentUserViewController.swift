//
//  CurrentUserViewController.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 8/20/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK

class CurrentUserViewController: UIViewController {

    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var userInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateUserInfo()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateUserInfo (){
        if(!Utility.loginStatus){
            self.dismiss(animated: false, completion: nil)
        }
        
        //var currentUser = Utility.userMap[Utility.currentUser]
        var userInfo = "Name: " + Utility.userMap[Utility.currentUser]!["$FirstName"]! + " " + Utility.userMap[Utility.currentUser]!["$LastName"]! + "\n"
        
        for userID in (Utility.userMap[Utility.currentUser]?.keys)!{
            NSLog("attribute is: " + userID)
            if(userID == "$FirstName" || userID == "$LastName"){
                continue
            }
            if(Utility.userIDMap.keys.contains(userID)){
                userInfo += Utility.userIDMap[userID]! + ": " + Utility.userMap[Utility.currentUser]![userID]! + "\n"
            }
            else{
                userInfo += userID + ": " + Utility.userMap[Utility.currentUser]![userID]! + "\n"
            }
            dump(Utility.userMap[Utility.currentUser]![userID])
        }
        userInfoLabel.text = userInfo
        
    }
    @IBAction func logout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        Utility.loginStatus = false
        Utility.currentUser = -1
        var currentUser = MParticle.sharedInstance().identity.currentUser
        let request = MPIdentityApiRequest(user: currentUser!)

        MParticle.sharedInstance().identity.logout(request, completion: {(apiResult, error) -> Void in
            if((error) != nil){

            }
            else{
                currentUser = apiResult?.user
            }
        })
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
