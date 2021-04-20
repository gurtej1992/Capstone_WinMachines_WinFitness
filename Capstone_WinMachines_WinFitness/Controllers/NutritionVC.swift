//
//  NutritionVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/15/21.
//

import UIKit
import Foundation

class NutritionVC: UIViewController {
    var images: [Image] = []
    

    @IBOutlet weak var tblNutrition: UITableView!

    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func createArray() -> [Image]{
        let im = Image(image: UIImage(named: "splash")!, title: "Break")
        return [im]
    }
    @IBAction func handleBreakfast(_ sender: UIButton) {
    }
    
    @IBAction func handleLunch(_ sender: UIButton) {
  }
    
    @IBAction func handleDinner(_ sender: UIButton) {
    }
    
    @IBAction func handleSnacks(_ sender: UIButton) {
    }
    
    @IBAction func handleBack(_ sender: UIButton) {
    }

    @IBAction func handleSearch(_ sender: UIButton) {
    }
}

class Image{
    var image: UIImage
    var title: String

    init(image: UIImage, title: String){
        self.image = image
        self.title = title
}
}
