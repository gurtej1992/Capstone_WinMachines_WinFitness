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
    
    @IBOutlet weak var tblNutrition: UITableView!
    var arrMeals = [Nutritions]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNutrition(type: .breakfast)
    }
    func getNutrition(type : Meal){
        arrMeals.removeAll()
        let ref = Database.database().reference().child("Nutrition")
        ref.child(type.rawValue).observe(.childAdded) { (snap) in
            if(snap.exists()){
                let snapshot  = snap.value as! [String:Any]
                let meal = Nutritions(image: snapshot["image"] as! String, link: snapshot["link"] as! String, name: snapshot["name"] as! String)
                self.arrMeals.append(meal)
                self.tblNutrition.reloadData()
            }
        }
    }
    
    @IBAction func handleBreakfast(_ sender: UIButton) {
        getNutrition(type: .breakfast)
        
    }
    @IBAction func handleLunch(_ sender: UIButton) {
        getNutrition(type: .lunch)  }
    
    
    @IBAction func handleDinner(_ sender: UIButton) {
        getNutrition(type: .dinner)    }
    
    @IBAction func handleSnacks(_ sender: UIButton) {
        getNutrition(type: .snacks)
        
    }
    
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func handleSearch(_ sender: UIButton) {
    }
}
extension NutritionVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NutritionTVC
        cell.configureCells(meal: arrMeals[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
    
}
