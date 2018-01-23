//
//  Toasts.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class Toasts {
    func isInternetAvailable() -> Bool
    {
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
    
    func noInternetConnectionError(atVC: UIViewController, tryAgain: @escaping () -> ()) -> () {
        let noConnectionAlert = UIAlertController(title: "No internet connection",
                                                  message: "",
                                                  preferredStyle: UIAlertControllerStyle.alert)
        noConnectionAlert.addAction(UIAlertAction(title: "Try again", style: .default,
                                                  handler: { (action: UIAlertAction!) in
                                                    tryAgain()
        }))
        atVC.present(noConnectionAlert, animated: true, completion: nil)
    }
    
    func loginSuccessAlert(atVC: UIViewController) {
        let loginSuccessAlert = UIAlertController(title: "Login successfull",
                                                  message: "",
                                                  preferredStyle: UIAlertControllerStyle.alert)
        loginSuccessAlert.addAction(UIAlertAction(title: "Ok", style: .default,
                                                  handler: { (action: UIAlertAction!) in
                                                    ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
        }))
        atVC.present(loginSuccessAlert, animated: true, completion: nil)
    }
    
    func loginFailedAlert(atVC: UIViewController) {
        let loginSuccessAlert = UIAlertController(title: "Login Failed",
                                                  message: "Something went wrong",
                                                  preferredStyle: UIAlertControllerStyle.alert)
        loginSuccessAlert.addAction(UIAlertAction(title: "Ok", style: .default,
                                                  handler: nil))
        atVC.present(loginSuccessAlert, animated: true, completion: nil)
    }
    
    //    func registerSuccessAlert(atVC: UIViewController) {
    //        let successAlert = UIAlertController(title: "Register successfull", message: "Maybe you want to login immediatly", preferredStyle: UIAlertControllerStyle.alert)
    //
    //        successAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    //
    //
    //
    //
    //        atVC.present(successAlert, animated: true, completion: nil)
    //    }
    
    func registerFailedAlert(atVC: UIViewController) {
        let registerFailedAlert = UIAlertController(title: "Register failed",
                                                    message: "Username already in use",
                                                    preferredStyle: UIAlertControllerStyle.alert)
        registerFailedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        atVC.present(registerFailedAlert, animated: true, completion: nil)
    }
    
    
    
    func invalidCredentialsAlert(atVC: UIViewController) {
        let invalidCredentialsAlert = UIAlertController(title: "Invalid credentials",
                                                        message: "Please enter valid credentials",
                                                        preferredStyle: UIAlertControllerStyle.alert)
        invalidCredentialsAlert.addAction(UIAlertAction(title: "Ok", style: .default,
                                                        handler: nil))
        atVC.present(invalidCredentialsAlert, animated: true, completion: nil)
    }
    
    func logoutAlert(atVC: UIViewController, onLogout: @escaping () -> ()) {
        let logoutAlert = UIAlertController(title: "Logout?",
                                            message: "Do you really want to log out?",
                                            preferredStyle: UIAlertControllerStyle.alert)
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .default,
                                            handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "Logout", style: .default,
                                            handler: { (action: UIAlertAction!) in
                                                onLogout()
        }))
        atVC.present(logoutAlert, animated: true, completion: nil)
    }
}

