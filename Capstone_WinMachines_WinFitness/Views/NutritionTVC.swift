//
//  NutritionTVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 20/04/21.
//

import UIKit
import SDWebImage

class NutritionTVC: UITableViewCell {
    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCells(meal : Nutritions){
        lbl.text = meal.name
        ImageCell.sd_setImage(with: URL(string: meal.image))
    }

}
