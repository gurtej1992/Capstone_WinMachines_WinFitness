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
    
    @IBOutlet weak var handleSignUp: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func handleLogin(_ sender: Any) {
        guard let pass = txtPass.text else {
            return
        }
        guard let email = txtEmail.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] auth, error in
            guard let strongSelf = self else { return }
            if error != nil{
                print(error?.localizedDescription ?? "")
                return
            }
            strongSelf.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
            
        }
    }
}
