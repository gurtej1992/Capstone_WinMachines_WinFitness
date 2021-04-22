//
//  BlurView.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 22/04/21.
//

import UIKit

class BlurView: UIView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
