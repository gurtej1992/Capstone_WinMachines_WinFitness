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
        
         self.player = Player()
         self.player.playerDelegate = self
         self.player.playbackDelegate = self
         self.player.view.frame = self.viewPlayer.bounds

         self.addChild(self.player)
         self.viewPlayer.addSubview(self.player.view)
         self.player.didMove(toParent: self)
        self.player.fillMode = .resizeAspectFill
        self.player.playbackLoops = true
        self.player.url = URL(string: "https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F1.mp4?alt=media&token=34c3d7e5-4c2c-4fc9-94e3-f983d449df3f")
        
    }
    @IBAction func handleNext(_ sender: Any) {
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
