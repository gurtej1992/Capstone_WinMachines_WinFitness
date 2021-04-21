//
//  HomeVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 19/04/21.
//

import UIKit
import Firebase
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
    @IBOutlet weak var viewToBlur: UIView!
    let arrPlan = ["Warm up","Full Body", "Rest","Legs Workout","Chest Workout","Rest","Full Body"]
    var arrWorkouts = [Workouts]()
    var currentUser : User!
    let arrMenu = ["Home","Invite Friends","Progress Pictures","Fav Workouts","Nutrition","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainerHeight.constant = view.frame.height
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToBlur.addSubview(blurEffectView)
        fetchUserDetails()
        fetchWorkouts()
    }
    func fetchUserDetails(){
        let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snap) in
            if snap.exists(){
                let snapshot = snap.value as! [String:Any]
                self.currentUser = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: snapshot["day"] as? Int ?? 0)
                self.lblUserName.text = self.currentUser.name
            }
        }
    }
    func fetchWorkouts(){
        let ref = Database.database().reference().child("Workouts")
        ref.observe(.childAdded) { (snap) in
            if(snap.exists()){
                let snapshot  = snap.value as! [String:Any]
                let equip = snapshot["Equipments"] as? [String]
                let work = Workouts(video: snapshot["video"] as? String ?? "", name: snapshot["WorkoutName"] as! String, desc: snapshot["desc"] as? String ?? "", type: snapshot["type"] as! String, equipment: equip)
                self.arrWorkouts.append(work)
            }
        }
    }
    @IBAction func handleProgress(_ sender: Any) {
    }
    @IBAction func handleNutrition(_ sender: Any) {
    }
    
    @IBAction func handleMenu(_ sender: Any) {
        if viewMenu.isHidden{
            viewMenu.isHidden = false
            viewMenuWidth.constant = (view.frame.width * 60)/100
        }
        else{
            viewMenu.isHidden = true
            viewMenuWidth.constant = 0
        }
    }
    @IBAction func handleMenuClose(_ sender: Any) {
        viewMenu.isHidden = true
        viewMenuWidth.constant = 0
    }
    @IBAction func handleSkipWorkout(_ sender: Any) {
    }
    @IBAction func handleStartWorkout(_ sender: Any) {
    }
    @IBAction func handleWeekDay(_ sender: UIButton) {
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !viewMenu.isHidden{
            handleMenuClose(self)
        }
    }
}
extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.textColor = .white
        cell?.textLabel?.font = UIFont(name: "DINCondensed-Bold", size: 25)
        cell?.textLabel?.text = arrMenu[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print(arrMenu[indexPath.row])
        case 1:
            print(arrMenu[indexPath.row])
        case 2:
            print(arrMenu[indexPath.row])
        case 3:
            print(arrMenu[indexPath.row])
        case 4:
            performSegue(withIdentifier: Constants.segToNutrition, sender: self)
        default:
            if let _ = Auth.auth().currentUser{
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popViewController(animated: true)
                }
                catch{
                }
            }
        }
        if !viewMenu.isHidden{
            handleMenuClose(self)
        }
    }
}
