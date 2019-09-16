//
//  PrivacyViewController.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 7/24/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK

class PrivacyViewController: UIViewController {

    @IBOutlet weak var dataSwitch: UISwitch!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var marketingSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSwitch.isOn = UserDefaults.standard.bool(forKey:"dataState")
        locationSwitch.isOn = UserDefaults.standard.bool(forKey:"locationState")
        marketingSwitch.isOn = UserDefaults.standard.bool(forKey:"marketingState")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dataConsentChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(dataSwitch.isOn, forKey: "dataState")
        changeConsent(consentType:"privacy", consentStatus: dataSwitch.isOn)
    }
    
    @IBAction func locationConsentChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(locationSwitch.isOn, forKey: "locationState")
        changeConsent(consentType:"location", consentStatus: locationSwitch.isOn)
    }
    
    @IBAction func marketingConsentChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(marketingSwitch.isOn, forKey: "marketingState")
        changeConsent(consentType:"marketing", consentStatus: marketingSwitch.isOn)
    }
    
    func changeConsent(consentType: String, consentStatus: Bool){
        let currentUser = MParticle.sharedInstance().identity.currentUser
        let dataPrivacy:MPGDPRConsent = MPGDPRConsent()
        dataPrivacy.consented = consentStatus
        
        let consentState : MPConsentState = MPConsentState()
        consentState.addGDPRConsentState(dataPrivacy, purpose: consentType)
        currentUser?.setConsentState(consentState)
        //dump(currentUser?.consentState()?.gdprConsentState()!["location"]?.consented)
        MParticle.sharedInstance().upload()
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
