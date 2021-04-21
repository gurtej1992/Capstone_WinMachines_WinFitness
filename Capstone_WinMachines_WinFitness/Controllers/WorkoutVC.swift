//
//  WorkoutVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/18/21.
//

import UIKit
import Player

class WorkoutVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUpNext: UILabel!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var lblReps: UILabel!
    @IBOutlet weak var lblNumSets: UILabel!
    @IBOutlet weak var viewBlur: UIView!
    var arrWorkouts = [Workouts]()
    var workoutCount = 0
    var player : Player!
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
        
         
        setWorkout()
        
    }
    func setWorkout(){
        let workout = arrWorkouts[workoutCount]
        if workout.type != "rest"{
            lblTitle.text = workout.name
                    lblReps.text = "10"
                    lblNumSets.text = "3"
            self.player = nil
            self.player = Player()
            self.player.playerDelegate = self
            self.player.playbackDelegate = self
            self.player.view.frame = self.viewPlayer.bounds

            self.addChild(self.player)
            self.viewPlayer.addSubview(self.player.view)
            self.player.didMove(toParent: self)
           self.player.fillMode = .resizeAspectFill
           self.player.playbackLoops = true
            self.player.url = URL(string: workout.video)
            if !self.player.isPlayingVideo{
                self.playerReady(self.player)
            }
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
extension WorkoutVC : PlayerDelegate,PlayerPlaybackDelegate{
    func playerReady(_ player: Player) {
        
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        
    }
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
        
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
        
    }
    
    func playerPlaybackDidLoop(_ player: Player) {
        
    }
    
    
}
