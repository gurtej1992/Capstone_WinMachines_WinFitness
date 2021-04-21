//
//  LoginVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    //Outlets for Login
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewLoginHeight: NSLayoutConstraint!
    // Outlets for Signup
    @IBOutlet weak var stackViewSignup: UIStackView!
    @IBOutlet weak var txtSemail: UITextField!
    @IBOutlet weak var txtSpass: UITextField!
    @IBOutlet weak var txtSname: UITextField!
    @IBOutlet weak var txtSconfirmPass: UITextField!
    // Variables
    var comeForLogin = true
    typealias Dic = [String:Any]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()

    }
    func prepareUI(){
        if comeForLogin{
            stackViewSignup.isHidden = true
            viewLoginHeight.constant = (view.frame.height * 40) / 100
            viewLogin.isHidden = false
        }
        else{
            stackViewSignup.isHidden = false
            viewLoginHeight.constant = 0
            viewLogin.isHidden = true
        }
    }
    @IBAction func handleNotRegistered(_ sender: Any) {
        comeForLogin = false
        prepareUI()
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleLogIn(_ sender: Any) {
    
    guard let pass = txtPass.text else {return}
    guard let email = txtEmail.text else {return}
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] auth, error in
            guard let strongSelf = self else { return }
            if error != nil{
                print(error?.localizedDescription ?? "")
                return
            }
            strongSelf.performSegue(withIdentifier: Constants.segToHome, sender: strongSelf)
        }
    }
    @IBAction func handleSignUp(_ sender: Any) {
        guard let email = txtSemail.text else {return}
        guard let name = txtSname.text else {return}
        guard let pass = txtSpass.text else {return}
        guard let confirm = txtSconfirmPass.text else {return}
        if confirm == pass {
            Auth.auth().createUser(withEmail: email, password: pass) { [weak self](auth, error) in
                guard let strongSelf = self else { return }
                if error != nil{
                    print(error?.localizedDescription ?? "")
                    return
                }
                let ref = Database.database().reference()
                let userDic = ["email":email,"name":name] as Dic
                ref.child("Users").child(auth!.user.uid).setValue(userDic)
                strongSelf.performSegue(withIdentifier: Constants.segToHome, sender: strongSelf)
            }
        }
            else{
                print("Password not matched")
            }
    }
}

