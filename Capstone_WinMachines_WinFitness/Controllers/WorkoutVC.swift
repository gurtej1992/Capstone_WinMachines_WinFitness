//
//  WorkoutVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 4/18/21.
//

import UIKit
import AVKit
import SRCountdownTimer
import PopupDialog
class WorkoutVC: UIViewController {

    @IBOutlet weak var viewCountDown: SRCountdownTimer!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUpNext: UILabel!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var lblReps: UILabel!
    @IBOutlet weak var lblNumSets: UILabel!
    @IBOutlet weak var viewBlur: UIView!
    @IBOutlet weak var btnNext: UIButton!
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
        if workoutCount != arrWorkouts.count - 1{
            lblUpNext.text = "Up Next : \(arrWorkouts[workoutCount + 1].name)"
        }
        else{
            lblUpNext.text = "Completed"
        }
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
        if btnNext.title(for: .normal) == "Done"{
            performSegue(withIdentifier: Constants.segToComplete, sender: self)
        }
        else{
            workoutCount += 1
            if workoutCount == arrWorkouts.count - 1 {
                btnNext.setTitle("Done", for: .normal)
            }
            if workoutCount < arrWorkouts.count{
                setWorkout()
                if arrWorkouts[workoutCount].type != "rest"{
                    clearAndPlay()
                    viewPlayer.isHidden = false
                    viewCountDown.isHidden = true
                }
                else{
                    viewPlayer.isHidden = true
                    viewCountDown.isHidden = false
                    viewCountDown.lineWidth = 10
                    viewCountDown.lineColor = Constants.ThemePink
                    viewCountDown.labelTextColor = UIColor.white
                    viewCountDown.labelFont = UIFont(name: "AvenirNextCondensed-Medium", size: 50)
                    viewCountDown.start(beginingValue: 35)
                }
            }
        }
        
    }
    @IBAction func handleInfo(_ sender: Any) {
        // Prepare the popup assets
        let title = "Workout Description"
        let message = arrWorkouts[workoutCount].desc
        let popup = PopupDialog(title: title, message: message)
        let buttonOne = CancelButton(title: "Okay") {
            print("You canceled the car dialog.")
        }
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
        
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
