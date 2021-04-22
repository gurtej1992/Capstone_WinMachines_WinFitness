//
//  ProfileSettingVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit

class ProfileSettingVC: UIViewController {

    @IBOutlet weak var lblTotalDistance: UILabel!
    @IBOutlet weak var lbTotalSteps: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleImageChange(_ sender: UIButton) {
    }
    

}
