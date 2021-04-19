//
//  LoginVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var txtPass: UITextField!
    
    @IBAction func handleSignUp(_ sender: Any) {
    }
   
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func handleLogIn(_ sender: Any) {
    
   
      
//    guard let pass = txtPass.text else {
//            return
//        }
//        guard; guard let email = txtEmail.text else { return <#default value#> }; else {
//            return
//        }
//        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] auth, error in
//            guard let strongSelf = self else { return }
//            if error != nil{
//                print(error?.localizedDescription ?? "")
//                return
//            }
//
//
//        }
    }
}

