//
//  CommunityTVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 2021-08-10.
//

import UIKit

class CommunityTVC: UITableViewCell {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.contentMode = .scaleAspectFill
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = Constants.ThemePink.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        imgProfile.clipsToBounds = true
    }

    @IBAction func handeLike(_ sender: UIButton) {
        if imgLike.tintColor == UIColor.red{
            imgLike.tintColor = .lightGray
        }
        else{
            imgLike.tintColor = .red
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
