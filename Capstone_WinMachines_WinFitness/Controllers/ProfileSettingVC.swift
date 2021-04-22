//
//  ProfileSettingVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase
import HealthKit

class ProfileSettingVC: UIViewController {
    
    @IBOutlet weak var viewToBlur: UIView!
    @IBOutlet weak var lblTotalDistance: UILabel!
    @IBOutlet weak var lbTotalSteps: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var imgUser: UIImageView!
    let store = HKHealthStore()
    var currentUser : User!
    
    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToBlur.addSubview(blurEffectView)
        imgUser.contentMode = .scaleAspectFill
        imgUser.layer.borderWidth = 5
        imgUser.layer.borderColor = Constants.ThemePink.cgColor
        imgUser.layer.cornerRadius = imgUser.frame.width/2
        imgUser.clipsToBounds = true
        fetchUserDetails()
        setupHealthKit()
    }
    func setupHealthKit(){
        
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {return}
        guard let walk = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {return}
        let woType = HKObjectType.workoutType()
        
        store.requestAuthorization(toShare: [], read: [stepType, woType,walk], completion: { (isSuccess, error) in
            if isSuccess {
                print("Working")
                self.getSteps()
                self.getDistance()
            } else {
                print("Not working")
            }
        })
    }
    func getSteps() {
        guard let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else{return}
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        let query = HKStatisticsQuery(
            quantityType: type,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                print(0.0)
                return
            }
            DispatchQueue.main.async { [self] in
                self.lbTotalSteps.text = "\(Int(sum.doubleValue(for: HKUnit.count())))"
            }
        }
        
        store.execute(query)
    }
    func getDistance(){
        guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Something went wrong retriebing quantity type distanceWalkingRunning")
        }
        let date =  Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
            var value: Double = 0
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let quantity = statistics?.sumQuantity() {
                value = quantity.doubleValue(for: HKUnit.mile())
            }
            DispatchQueue.main.async { [self] in
                self.lblTotalDistance.text = "\(value) in mile"
            }
        }
        store.execute(query)
    }
    func fetchUserDetails(){
        let _ = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observe(.value) { [weak self](snap) in
            guard let strongSelf = self else { return }
            if snap.exists(){
                let snapshot = snap.value as! [String:Any]
                let day = Int((snapshot["day"] as! String)) ?? 1
                strongSelf.currentUser = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: day)
                strongSelf.setUserDetails()
            }
        }
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
        guard let email = txtEmail.text,let name = txtName.text,let dob = txtDob.text,let height = txtHeight.text,let weight = txtWeight.text else {
            return
        }
        let userDic = ["name":name,"email":email,"height":height,"weight":weight,"dob":dob] as [String : Any]
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userDic)
        
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleImageChange(_ sender: UIButton) {
    }
    func setUserDetails(){
        self.txtEmail.text = self.currentUser.email
        self.txtDob.text = self.currentUser.dob
        self.txtWeight.text = self.currentUser.weight
        self.txtHeight.text = self.currentUser.height
        self.txtName.text = self.currentUser.name
        self.imgUser.sd_setImage(with: URL(string:self.currentUser.picture), placeholderImage: UIImage(named: "splash"))
    }
    
}
