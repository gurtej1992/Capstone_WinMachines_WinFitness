//
//  NutritionVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 4/15/21.
//

import UIKit
import Foundation
import Firebase

class NutritionVC: UIViewController {
    
    @IBOutlet var btnMeals: [UIButton]!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblNutrition: UITableView!
    var usingSearch = false
    var arrFilterMeals = [Nutritions]()
    var arrMeals = [Nutritions]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNutrition(type: .breakfast)
    }
    @IBAction func handleSearch(_ sender: Any) {
        if searchBar.isHidden{
            searchBar.isHidden = false
        }
        else{
            searchBar.isHidden = true
            usingSearch = false
            tblNutrition.reloadData()
        }
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
}
extension NutritionVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = usingSearch ? arrFilterMeals : arrMeals
        return meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NutritionTVC
        let meal = usingSearch ? arrFilterMeals[indexPath.row] : arrMeals[indexPath.row]
        cell.configureCells(meal: meal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = usingSearch ? arrFilterMeals[indexPath.row] : arrMeals[indexPath.row]
        guard let url = URL(string: meal.link) else { return }
        UIApplication.shared.open(url)    }
}
extension NutritionVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usingSearch = true
        arrFilterMeals.removeAll()
        arrFilterMeals = arrMeals.filter({($0.name.contains(searchText))})
        tblNutrition.reloadData()
    }
    
}
