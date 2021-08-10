//
//  CommunityTVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 2021-08-10.
//

import UIKit

class CommunityTVC: UITableViewCell {

    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
