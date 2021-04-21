//
//  WorkoutVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/18/21.
//

import UIKit

class WorkoutVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUpNext: UILabel!
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var lblReps: UILabel!
    @IBOutlet weak var lblNumSets: UILabel!
    @IBOutlet weak var viewBlur: UIView!
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
        
    }
    @IBAction func handleNext(_ sender: Any) {
    }
    @IBAction func handleInfo(_ sender: Any) {
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

