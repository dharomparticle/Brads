//
//  ViewController.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 7/24/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK
import mParticle_Apple_Inspector
class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var event2Btn: UIButton!
    @IBOutlet weak var debugBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = Utility.backgroundColor
        event2Btn.isHidden = Utility.disableEvent2
        debugBtn.isHidden = Utility.disableDebugBtn
        var currentUser = MParticle.sharedInstance().identity.currentUser
        if(Utility.loginStatus){
            loginButton.setTitle("Current User", for: .normal)
        }
        else{
            loginButton.setTitle("Login", for: .normal)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callInspector(_ sender: Any) {
        self.navigationController?.pushViewController(AppDelegate.inspectorVC, animated: true)
    }
    
    @IBAction func callLoginScreen(_ sender: UIButton) {
        if(!Utility.loginStatus){
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginPage") as? LoginViewController
            self.present(vc!, animated: true, completion: nil)
        }
        else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "currentUserPage") as? CurrentUserViewController
            self.present(vc!, animated: true, completion: nil)
        }
        
        
    }
}

