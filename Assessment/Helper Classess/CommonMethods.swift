//
//  CommonMethods.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import UIKit
import Foundation
import SystemConfiguration
import CoreData
import SwiftyJSON
import KRProgressHUD

class CommonMethods: NSObject {
    
    class func showAlert(message: String, view: UIViewController) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    class func goToViewController(storyboard:UIStoryboard, identifier:String, navigation:UINavigationController) {
        let objVC = storyboard.instantiateViewController(withIdentifier: identifier)
        navigation.pushViewController(objVC, animated: true)
    }
    
    
    class func showAlertMessage(title: String, message: String, view: UIViewController) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //Do some other stuff
        }
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    
    class func showAlertMessageWithHandler(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //Do some other stuff
            completion()
        }
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    
    class func showAlertMessageWithOkAndCancel(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            //Do some other stuff
            completion()
        }
        let cancelActon: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some other stuff
        }
        
        objAlert.addAction(cancelActon)
        objAlert.addAction(nextAction)
        view.present(objAlert, animated: true, completion: nil)
    }
    
    
    class func showAlertMessageWithLoginAndCancel(title: String, message: String, view: UIViewController, completion: @escaping () -> Void) {
        let objAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelActon: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Do some other stuff
        }
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Login", style: .default) { action -> Void in
            //Do some other stuff
            completion()
        }
        objAlert.addAction(nextAction)
        objAlert.addAction(cancelActon)
        view.present(objAlert, animated: true, completion: nil)
    }
    
     
    //  MARK:-
    //  MARK:-  Check Internet Connection
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    class func convertTextIntoLink(linkText:String, text:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: linkText, range: NSRange(location: 19, length: 55))
        return attributedString
    }
    
     
    class func convertNumbers(numberString: String) -> String {
      guard let number = Double(numberString) else {
        return "Invalid number format"
      }
      
      if number >= 1000 {
        return String(format: "%.1fK", number / 1000)
      } else {
        return numberString
      }
    }

    
    /*****-------***** Save Status *****-------*****/
    class func saveStatusForKey(status:Bool, forKey:String) {
        UserDefaults.standard.set(status, forKey: forKey)
        UserDefaults.standard.synchronize()
    }

    /*****-------***** Get Status *****-------*****/
    class func getStatusForKey(forKey:String) -> Bool{
        return UserDefaults.standard.bool(forKey:forKey)
    }
    
    /*****-------***** Save Value *****-------*****/
    class func saveValueForKey(value:String, forKey:String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    /*****-------***** Get Value *****-------*****/
    class func getValueForKey(key:String) -> String {
        return UserDefaults.standard.value(forKey: key) as? String ?? "0"
    }
}
