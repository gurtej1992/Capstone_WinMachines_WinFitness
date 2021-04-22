//
//  ProfileSettingVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase

class ProfileSettingVC: UIViewController {

    @IBOutlet weak var viewToBlur: UIView!
    @IBOutlet weak var lblTotalDistance: UILabel!
    @IBOutlet weak var lbTotalSteps: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    var currentUser : User!
    
    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToBlur.addSubview(blurEffectView)
        fetchUserDetails()
    }
    func fetchUserDetails(){
        let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observe(.value) { (snap) in
            if snap.exists(){
                let snapshot = snap.value as! [String:Any]
                let day = Int((snapshot["day"] as! String)) ?? 1
                self.currentUser = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: day)
               
            }
        }
    }
    @IBAction func handleSave(_ sender: UIButton) {
        guard let email = txtEmail.text,let name = txtName.text,let dob = txtDob.text,let height = txtHeight,let weight = txtWeight.text else {
            return
        }
        let userDic = ["name":name,"email":email,"height":height,"weight":weight,"dob":dob] as [String : Any]
        //let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).update
        
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleImageChange(_ sender: UIButton) {
    }
    

}
