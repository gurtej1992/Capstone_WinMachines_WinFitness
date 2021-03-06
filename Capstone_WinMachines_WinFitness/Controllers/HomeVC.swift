//
//  HomeVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Mac on 19/04/21.
//

import UIKit
import Firebase
import SDWebImage
class HomeVC: UIViewController {
    @IBOutlet weak var btnWorkout: UIButton!
    @IBOutlet var btnWeekDays: [UIButton]!
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblWorkoutTitle: UILabel!
    @IBOutlet weak var stackViewEquip: UIStackView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewEquipments: UIView!
    @IBOutlet weak var viewContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var viewToBlur: UIView!
    let arrPlan = ["Warm up","Full Body", "Rest","Legs Workout","Chest Workout","Rest","Full Body"]
    let arrTime = ["10","30","1","20","30","1","50"]
    let arrEquip = [["Mats"],["Mats","Dumbell","Barbell"],[],["Mats","Dumbell"],["Mats","Dumbell","Barbell"],[],["Mats","Barbell","Bench","Dumbell"]]
    var arrWorkouts = [Workouts]()
    var currentUser : User!
    let arrMenu = ["Home","Invite Friends","Progress Pictures","Profile Setting","Nutrition","Community","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        fetchUserDetails()
        fetchWorkouts()
    }
    
    func prepareUI(){
        // Added BlurView to Menu
        viewContainerHeight.constant = view.frame.height
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToBlur.addSubview(blurEffectView)
        
        imgProfile.contentMode = .scaleAspectFill
        imgProfile.layer.borderWidth = 5
        imgProfile.layer.borderColor = Constants.ThemePink.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        imgProfile.clipsToBounds = true
    }
    func fetchUserDetails(){
        let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observe(.value) { (snap) in
            if snap.exists(){
                let snapshot = snap.value as! [String:Any]
                let day = Int((snapshot["day"] as! String)) ?? 1
                self.currentUser = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: day)
                for btn in self.btnWeekDays{
                    if btn.tag == day{
                        btn.backgroundColor = Constants.ThemePink
                    }
                    else{
                        btn.backgroundColor = UIColor.clear
                    }
                }
                self.setWorkout(day: day - 1)
                self.lblUserName.text = self.currentUser.name
                self.lblUserEmail.text = self.currentUser.email
                self.imgProfile.sd_setImage(with: URL(string:self.currentUser.picture), placeholderImage: UIImage(named: "splash"))
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
    func setWorkout(day : Int){
        for (_,view) in stackViewEquip.subviews.enumerated(){
            view.removeFromSuperview()
        }
        //let workout = arrWorkouts[day]
        lblWorkoutTitle.text = arrPlan[day]
        if arrPlan[day] == "Rest"{
            lblTime.text = "TIME 1 DAY"
            btnWorkout.isHidden = true
        }
        else{
            btnWorkout.isHidden = false
            lblTime.text = "TIME \(arrTime[day]) MINUTES"
            for eq in arrEquip[day]{
                let lbl = UILabel()
                lbl.text = eq
                lbl.textColor = .white
                lbl.font = UIFont(name: "DINCondensed-Bold", size: 25)
                stackViewEquip.addArrangedSubview(lbl)
            }
        }
        
        
    }
    func inviteFriends(){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "Check out my fitness secret WinFitness"
        
        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {
            let objectsToShare = [textToShare, myWebsite, image ?? UIImage(named: "splash")!] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }    }
    
    @IBAction func handleProgress(_ sender: Any) {
        performSegue(withIdentifier: Constants.segToProgress, sender: self)
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
        if currentUser.day != 7{
            let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["day":String(currentUser.day + 1)])
        }
    }
    @IBAction func handleStartWorkout(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.WorkoutVC) as! WorkoutVC
        vc.arrWorkouts = arrWorkouts
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func handleWeekDay(_ sender: UIButton) {
        setWorkout(day: sender.tag - 1)
        for btn in btnWeekDays{
            if btn.tag == sender.tag{
                btn.backgroundColor = Constants.ThemePink
            }
            else{
                btn.backgroundColor = UIColor.clear
            }
        }
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
            handleMenuClose(self)
        case 1:
            inviteFriends()
        case 2:
            performSegue(withIdentifier: Constants.segToProgress, sender: self)
        case 3:
            performSegue(withIdentifier: Constants.segToProfile, sender: self)
        case 4:
            performSegue(withIdentifier: Constants.segToNutrition, sender: self)
        case 5:
            performSegue(withIdentifier: Constants.segToCommunity, sender: self)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
