//
//  WelcomeVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = Auth.auth().currentUser{
            let vc = storyboard?.instantiateViewController(identifier: Constants.HomeVC) as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segToSignup{
            let vc = segue.destination as! LoginVC
            vc.comeForLogin = false
        }
    }

    @IBAction func handleLogin(_ sender: Any) {
        performSegue(withIdentifier: Constants.segToLogin, sender: self)
    }
    @IBAction func handleSingup(_ sender: Any) {
        performSegue(withIdentifier: Constants.segToSignup, sender: self)
    }
}
