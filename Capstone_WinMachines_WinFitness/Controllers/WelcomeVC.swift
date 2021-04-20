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
        createWorkouts()
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
    func createWorkouts(){
        let x =  ["WorkoutName":"","Equipments":["mats","barbell"],"video":"","type":"reps"] as [String : Any]
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x)
        
        let y = ["workoutID":"","reps":"15","sets"]
        let _ = Database.database().reference().child("WorkoutPlan").child("0").child(<#T##pathString: String##String#>)
    }
}
