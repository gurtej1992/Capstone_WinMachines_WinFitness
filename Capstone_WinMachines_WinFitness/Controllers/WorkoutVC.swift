//
//  WorkoutVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/18/21.
//

import UIKit

class WorkoutVC: UIViewController {

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
}

