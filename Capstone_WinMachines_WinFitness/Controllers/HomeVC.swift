//
//  HomeVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 19/04/21.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var btnWeekDays: [UIButton]!
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblWorkoutTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewEquipments: UIView!
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewMenuWidth: NSLayoutConstraint!
    let arrMenu = ["Home","Invite Friends","Progress Pictures","Fav Workouts","Nutrition"]
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainerHeight.constant = view.frame.height
    }
    @IBAction func handleProgress(_ sender: Any) {
    }
    @IBAction func handleNutrition(_ sender: Any) {
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        if viewMenu.isHidden{
            viewMenu.isHidden = false
            viewMenuWidth.constant = (view.frame.width * 70)/100
        }
        else{
            viewMenu.isHidden = true
            viewMenuWidth.constant = 0
        }
    }
    @IBAction func handleSkipWorkout(_ sender: Any) {
    }
    @IBAction func handleStartWorkout(_ sender: Any) {
    }
    @IBAction func handleWeekDay(_ sender: UIButton) {
    }
    
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = arrMenu[indexPath.row]
        return cell!
    }
}
