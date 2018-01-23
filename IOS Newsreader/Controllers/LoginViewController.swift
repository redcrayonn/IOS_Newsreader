//
//  LoginViewController.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 23/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginService: LoginService = LoginService()
    let toasts: Toasts = Toasts()
    
    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginClick(_ sender: Any) {
        if toasts.isInternetAvailable(){
            if ((loginUsername.text == "" && loginPassword.text == "") ||
                (loginUsername.text == "" || loginPassword.text == "")) {
                self.toasts.invalidCredentialsAlert(atVC: self)
            } else {
                loginService.login(username: loginUsername.text!,
                                   password: loginPassword.text!,
                                   onSuccess: {
                                    DispatchQueue.global().async(execute: {
                                        DispatchQueue.main.sync {
                                                self.toasts.loginSuccessAlert(atVC: self)
                                            }
                                        }
                                    )
                
                }) {
                    DispatchQueue.main.async {
                        self.toasts.invalidCredentialsAlert(atVC: self)
                    }
                }
            }
        } else {
            self.toasts.noInternetConnectionError(atVC: self, tryAgain: {
                // no action needed
            })
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
