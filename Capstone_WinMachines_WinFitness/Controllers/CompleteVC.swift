//
//  CompleteVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 22/04/21.
//

import UIKit
import Firebase

class CompleteVC: UIViewController {
    var currentUser = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
        
    }
    func fetchUserDetails(){
        let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snap) in
            if snap.exists(){
                let snapshot = snap.value as! [String:Any]
                let day = Int((snapshot["day"] as! String)) ?? 1
                self.currentUser = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: day)
                self.saveExcercise()
               
            }
        }
    }
    func saveExcercise(){
        if currentUser.day != 7{
            let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["day":String(currentUser.day + 1)])
        }
    }
    @IBAction func handleDone(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
