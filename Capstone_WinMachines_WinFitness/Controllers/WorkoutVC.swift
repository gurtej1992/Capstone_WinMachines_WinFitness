//
//  WorkoutVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/18/21.
//

import UIKit
import AVKit

class WorkoutVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUpNext: UILabel!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var lblReps: UILabel!
    @IBOutlet weak var lblNumSets: UILabel!
    @IBOutlet weak var viewBlur: UIView!
    var arrWorkouts = [Workouts]()
    var workoutCount = 0
    var player : AVPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    func prepareUI(){
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewBlur.addSubview(blurEffectView)
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
         player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.viewPlayer.bounds
        self.viewPlayer.layer.addSublayer(playerLayer)
        player.play()
         
        setWorkout()
        
    }
    func setWorkout(){
        let workout = arrWorkouts[workoutCount]
        if workout.type != "rest"{
            lblTitle.text = workout.name
                    lblReps.text = "10"
                    lblNumSets.text = "3"
            
        }
    }
    @IBAction func handleNext(_ sender: Any) {
        workoutCount += 1
        setWorkout()
    }
    @IBAction func handleInfo(_ sender: Any) {
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
