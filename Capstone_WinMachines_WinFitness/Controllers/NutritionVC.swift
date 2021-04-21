//
//  NutritionVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/15/21.
//

import UIKit
import Foundation
import Firebase

class NutritionVC: UIViewController {
    
    var images: [Image] = []
    @IBOutlet weak var tblNutrition: UITableView!
    var arrBreakfast = [Nutritions]()
    var arrLunch = [Nutritions]()
    var arrDinner = [Nutritions]()
    var arrSnacks = [Nutritions]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNutrition()
    }
    func getNutrition(type : Meal){
        let ref = Database.database().reference().child("Nutrition")
        ref.child("Breakfast").observe(.childAdded) { (snap) in
            if(snap.exists()){
                let snapshot  = snap.value as! [String:Any]
                let breakfast = Nutritions(image: snapshot["image"] as! String, link: snapshot["link"] as! String, name: snapshot["name"] as! String)
                self.arrBreakfast.append(breakfast)
                self.tblNutrition.reloadData()
            }
        }
        
    }
    func createArray() -> [Image]{
        let im = Image(image: UIImage(named: "Breakfast Image")!, title: "Morning Diet")
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
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func handleSearch(_ sender: UIButton) {
    }
}
extension NutritionVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NutritionTVC
        cell.lbl.text = ""
        return cell
    }
    
    
}
