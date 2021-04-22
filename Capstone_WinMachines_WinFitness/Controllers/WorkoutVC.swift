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
        let videoURL = URL(string:arrWorkouts[workoutCount].video)
         player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.viewPlayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.viewPlayer.layer.addSublayer(playerLayer)
        player.play()
        setWorkout()
        
    }
    func setWorkout(){
            lblTitle.text = arrWorkouts[workoutCount].name
            lblReps.text = "10"
            lblNumSets.text = "3"
    }
    func clearAndPlay(){
        if let player = self.player{
                player.pause()
                self.player = nil
            }
        self.viewPlayer.layer.sublayers?.removeAll()
        let videoURL = URL(string:arrWorkouts[workoutCount].video)
         player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.viewPlayer.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.viewPlayer.layer.addSublayer(playerLayer)
        player.play()
        
    }
    @IBAction func handleNext(_ sender: Any) {
        workoutCount += 1
        if workout.type != "rest"{
            setWorkout()
            clearAndPlay()
        }
        
    }
    @IBAction func handleInfo(_ sender: Any) {
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
