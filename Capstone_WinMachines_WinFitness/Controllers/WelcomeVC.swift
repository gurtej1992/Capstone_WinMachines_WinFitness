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
        let x1 =  ["WorkoutName":"Squats",
                  "Equipments":[],
                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F1.mp4?alt=media&token=34c3d7e5-4c2c-4fc9-94e3-f983d449df3f",
                  "type":"reps","desc":"Sit back – make sure to move your butt backward, don’t just bend your knees. Be careful to keep your knees in line with your toes, don’t let them cave in. Don’t forget about your upper body – look straight ahead and don’t round your back"] as [String : Any]
        let x2 =  ["WorkoutName":"Glute Bridge",
                  "Equipments":["Mats"],
                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F3.mp4?alt=media&token=871e85cc-d1d4-4abc-863b-5d9942ba99fa",
                  "type":"time","desc":"Lie face up on the floor, with your knees bent and feet flat on the ground. Keep your arms at your side with your palms down.Lift your hips off the ground until your knees, hips and shoulders form a straight line. Squeeze those glutes hard and keep your abs drawn in so you don’t overextend your back during the exercise.Hold your bridged position for a couple of seconds before easing back down."] as [String : Any]
        let x3 =  ["WorkoutName":"Rest",
                  "type":"rest"] as [String : Any]
        let x4 =  ["WorkoutName":"Dumbbell Biceps Curl",
                  "Equipments":["Mats","Dumbell"],
                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F2.mp4?alt=media&token=a995f7b2-5013-455c-9516-d5f0bdf2d8f9",
                  "type":"reps","desc":"From standing, use an underhand grip to curl the weight into your shoulders. Avoid swinging the weights and keep your elbows forward and close to your sides."] as [String : Any]
        
        let x5 =  ["WorkoutName":"Crunches",
                  "Equipments":["Mats"],
                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F4.mp4?alt=media&token=453ee386-f6da-4e95-832a-246082badda9",
                  "type":"reps","desc":"Lie down on your back. Plant your feet on the floor, hip-width apart. Bend your knees and place your arms across your chest. Contract your abs and inhale.Exhale and lift your upper body, keeping your head and neck relaxed.Inhale and return to the starting position."] as [String : Any]
        let x6 =  ["WorkoutName":"Rest",
                  "type":"rest"] as [String : Any]
        let x7 =  ["WorkoutName":"Dumbbell lying squats",
                  "Equipments":["Mats","Dumbell"],
                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F6.mp4?alt=media&token=f8c2f87a-d9ee-42be-ae20-db44bec4fd41",
                  "type":"reps","desc":"Lie face down and extend your arms forward and your legs back. Lift your chest and legs off the ground, and hold this position as you perform a rowing movement squeezing the traps."] as [String : Any]
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x1)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x2)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x3)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x4)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x5)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x6)
        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x7)
      
    }
}
