//
//  Utility.swift
//  mP_Template
//
//  Created by Rohit Kulkarni on 7/24/18.
//  Copyright © 2018 Rohit Kulkarni. All rights reserved.
//

import UIKit
import mParticle_Apple_SDK

class Utility: NSObject {
    
    /***********************************************************BEGIN Configuration Constants - DO NOT CHANGE***********************************************************/
    static var currentUser = -1
    static var loginStatus = false
    static var userIDMap = ["$FirstName" : "First Name", "$Last Name" : "Last Name", "$Age": "Age", "$Gender" : "Gender", "$Mobile" : "Mobile", "$Address" : "Address", "$City" : "City", "$State" : "State", "$Zip" : "Zip", "$Country" : "Country", "customerid" : "Customer ID", "email" : "Email", "facebook" : "Facebook ID", "facebookcustomaudienceid" : "Facebook Audience ID", "google" : "Google ID", "twitter" : "Twitter ID", "microsoft" : "Microsoft ID", "yahoo" : "Yahoo ID", "other" : "Other"]
    static var trackingTypes = ["Event", "Ecommerce", "Screen", "Location", "Error"]
    static var eventTypes = [MPEventType.transaction, MPEventType.navigation, MPEventType.search, MPEventType.other, MPEventType.userPreference]
    static var commActionMap : [String:UInt] = ["Add to Cart" : 0, "Remove from Cart" : 1, "Add to WishList" : 2, "Remove from WishList" : 3, "Checkout" : 4, "Checkout Options" : 5, "Click" : 6, "View Detail" : 7, "Purchase" : 8, "Refund" : 9]
    static var statusBarTextMap : [String:UIStatusBarStyle] = ["light" : .lightContent, "default" : .default]
    
    /***********************************************************END Configuration Constants - DO NOT CHANGE***********************************************************/
    
    /***********BEGIN Global Settings***********/
    static let mPKey = "a8c4b2a8773c9d49a022cdeef150376a"
    static let mPSecret = "roXJX7VCFoa5xvVIsLAC5HMyX5F9rJ9-aJkb9ULaLpwABTCZ1HO2mtIUUs3z7tis"
    let titleText = "Brad's Deals"
    static var titleTextColor = UIColor.white
    var buttonFill = UIColor.init(red: 15/255, green: 60/255, blue: 73/255, alpha: 1)
    //rgb(107,250,207)
    var buttonText = UIColor.white
    static var backgroundColor = UIColor.white
    static var navBarColor = UIColor.init(red: 15/255, green: 60/255, blue: 73/255, alpha: 1)
    static var navBarText = UIColor.white
    
    //default or light
    static var statusBarText = "light"
    static var disableDebugBtn = true
    
    /***********END Global Settings***********/
    
    
    /***********************BEGIN Event 1 Configuration***********************/
    
    //Overall event displayed
    static var overallEvent1 = "Deals"
    static var overallEvent1Screen = ["Screen Type" : "Deals"]
    //Events displayed on the screen
    static var event1 = ["View New Deals", "View Deal", "Buy Now"]
    static var differentEvent1Names = false
    //replace the below if names are different than titles
    static var event1Names = ["replaced name","second replaced","third"]

    
    //Messages presented to the user and also sent to mParticle (indexing matches "event1" list above)
    static var event1MessageMap = [
        0 : "View New Deals",
        1 : "View Leopard-Print Coat $40 Shipped",
        2 : "Redirect to purchase Leopard-Print Coat"
    ]
    
    static var event1AlertTitle = [
        0 : "New Deals",
        1 : "Item Viewed",
        2 : "Redirect to Purchase"
    ]
    
    //Variable to set if messages returned to the user and mParticle will be specfied by "event1MessageMap" above or just generic string with the event in the string
    static var genericMessageEvent1 = false;
    
    //Sets the tracking type (Event, Ecommerce, Screen, Error, etc) - refer to "trackingTypes" list declared above
    static var event1TrackingTypeMap = [
        0 : trackingTypes[0],
        1 : trackingTypes[0],
        2 : trackingTypes[0]
    ]
    
    //Sets the event type for regular events (Transaction, Search, Navigation, etc) - refer to "eventTypes" list declared above
    static var event1TypeMap = [
        0 : eventTypes[3],
        1 : eventTypes[3],
        2 : eventTypes[3]
    ]
    
    
    
    //Regular Event Information
    static var event1Info = [
        0 : [:],
        1 : ["Store" : "OC Style Apparel","Product" : "Leopard-Print Coat", "Price" : "$40"],
        2 : [:]
    ]
    
    static var event1ErrorReason = [
        2 : ["test":"test"]
        
    ]
    
    /***Ecommerce Event Information***/
    
    //Product Info
    static var event1EcommProdInfo = [
        2: ["Product" : "The Transport Tote", "SKU" : "T84939", "Quantity" : 1, "Price" : 168]
    ]
    
    //Action Type Info - Should match with variable "commActionMap" declared above
    static var event1EcommActionInfo = [
        2: "Purchase"
    ]
    
    //Transaction attribute info
    static var event1EcommAttInfo = [
        2: ["Transaction ID" : "T-98373", "Revenue" : 168, "Tax" : 15.12, "Shipping" : 0]
    ]
    
    static var event1EcommCustomAttInfo = [
        2 : ["Category" : "Bags", "Color" : "Black"]
    ]
    /***Ecommerce Event Information***/
    
    
    //Screen Tracking Information
    static var event1ScreenInfoMap = [
        1 : ["Name" : "Shopping Cart", "Info" : ["Screen Type" : "Cart"]]
    ]
    
    /***********************END Event 1 Configuration***********************/
    
    /***********************BEGIN Event 2 Configuration***********************/
    
    static var disableEvent2 = false
    //Overall event displayed
    static var overallEvent2 = "Saved Items"
    static var overallEvent2Screen = ["Screen Type" : "Saved Items"]
    
    //Events displayed on the screen
    static var event2 = ["View Item", "Share Item", "Buy Now"]
    static var differentEvent2Names = false
    //replace the below if names are different than titles
    static var event2Names = ["replaced name","second replaced","third"]
    
    //Messages presented to the user and also sent to mParticle
    static var event2MessageMap = [
        0 : "View Sterling Names Necklace $22 Shipped",
        1 : "Deal Share on Facebook",
        2 : "Redirect to purchase Sterling Names Necklace"
    ]
    
    static var event2AlertTitle = [
        0 : "Item Viewed",
        1 : "Item Shared",
        2 : "Redirect to Purchase"
    ]
    
    //Variable to set if messages returned to the user and mParticle will be specfied by "event2MessageMap" above or just generic string with the event in the string (i.e. [event1] Selected)
    static var genericMessageEvent2 = false;
    
    //Sets the tracking type (Event, Ecommerce, Screen, Error, etc) - refer to "trackingTypes" list declared above
    static var event2TrackingTypeMap = [
        0 : trackingTypes[0],
        1 : trackingTypes[0],
        2 : trackingTypes[0]
    ]
    
    //Sets the event type for regular events (Transaction, Search, Navigation, etc) - refer to "eventTypes" list declared above
    static var event2TypeMap = [
        0 : eventTypes[3],
        1 : eventTypes[3],
        2 : eventTypes[3]
    ]
    
    //Regular Event Information
    static var event2Info = [
        0 : ["Store" : "Limoges Jewelry","Product" : "Sterling Names Necklace", "Price" : "$22"],
        1 : [:],
        2 : [:]
    ]
    
    static var event2ErrorReason = [
        2 : ["test":"test"]
        
    ]
    
    /***BEGIN Ecommerce Event Information***/
    
    //Product Info
    static var event2EcommProdInfo = [
        2: ["Product" : "Laptop", "SKU" : "L9987", "Quantity" : 1, "Price" : 1341.37]
    ]
    
    //Action Type Info - Should match with variable "commActionMap" declared above
    static var event2EcommActionInfo = [
        2: "Purchase"
    ]
    
    //Transaction attribute info
    static var event2EcommAttInfo = [
        2: ["Transaction ID" : "T-98373", "Revenue" : 1342, "Tax" : 132.76, "Shipping" : 120]
    ]
    
    static var event2EcommCustomAttInfo = [
        6 : ["att1":"val1"],
        7 : [:],
        8 : [:]
    ]
    /***END Ecommerce Event Information***/
    
    //Screen Tracking Information
    static var event2ScreenInfoMap = [
        1 : ["Name" : "Returns", "Info" : ["Screen Type" : "Orders"]]
    ]
    
    /***********************END Event 2 Configuration***********************/
    
    static var userMap = [
        0: [
            "$FirstName" : "Dave",
            "$LastName" : "Haro",
            "email" : "dave.mparticle@gmail.com",
            "$Age" : "32",
            "facebook" : "f-lgr-16",
            "twitter" : "t-lgr-16",
            "customerid" : "6646"
        ],
        1: [
            "$FirstName" : "Clark",
            "$LastName" : "West",
            "email" : "cwest@"+Utility().titleText+".com",
            "microsoft" : "m-cwest-334",
            "yahoo" : "y-cwest-334",
            "customerid" : "343434"
            
        ]
    ]
}
extension UINavigationItem {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.title = Utility().titleText
        
    }
}

extension UIImageView{
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.image = UIImage(named: "logo.jpg")
    }
}
extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if self.tag > 100{
            self.titleLabel?.font =  UIFont(name: "Avenir", size: 12)
            self.setTitleColor(Utility().buttonFill, for: UIControlState.normal)
            
            self.backgroundColor = .white
            self.layer.borderColor = Utility().buttonFill.cgColor
            
        }
            
        else {
            
            self.titleLabel?.font =  UIFont(name: "Avenir", size: 20)
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            self.setTitleColor(Utility().buttonText, for: UIControlState.normal)
            self.backgroundColor = Utility().buttonFill
            self.titleLabel?.tintColor = Utility().buttonFill
            self.titleLabel?.textColor = Utility().buttonFill
            self.layer.borderColor = Utility().buttonFill.cgColor
            self.layer.borderWidth = 1
            if self.tag == 1{
                self.setTitle(Utility.overallEvent1, for: UIControlState.normal)
            }
            else if self.tag == 2{
                self.setTitle(Utility.overallEvent2, for: UIControlState.normal)
            }
            
            self.layer.cornerRadius = 20
            self.clipsToBounds = true
        }
    }
}
