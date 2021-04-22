//
//  ProfileSettingVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase
import HealthKit
import PopupDialog
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
    var isImageUpdated = false
    var imagePicker = UIImagePickerController()
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
        if isImageUpdated{
            if let data = imgUser.image?.jpegData(compressionQuality: 0.3){
                let storageRef = Storage.storage().reference()
                let riversRef = storageRef.child("images/\(UUID().uuidString).jpg")

                // Upload the file to the path "images/rivers.jpg"
                let _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                  let _ = metadata.size
                  // You can also access to download URL after upload.
                  riversRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      return
                    }
                    let userDic = ["name":name,"email":email,"height":height,"weight":weight,"dob":dob,"picture":downloadURL.absoluteString] as [String : Any]
                    Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userDic)
                    self.navigationController?.popViewController(animated: true)
                  }
                }
            }
        }
        else{
            let userDic = ["name":name,"email":email,"height":height,"weight":weight,"dob":dob] as [String : Any]
            Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(userDic)
        }
        let title = "Success"
        let message = "Your profile has been successfully updated."
        let popup = PopupDialog(title: title, message: message)
        let buttonOne = CancelButton(title: "Okay") {
            print("You canceled the car dialog.")
        }
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
    }
    @IBAction func handleBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleImageChange(_ sender: UIButton) {
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let cameraAction: UIAlertAction = UIAlertAction(title: "Image From Camera", style: .default) { action -> Void in
                self.handleCamera()
            }

            let mediaAction: UIAlertAction = UIAlertAction(title: "Image From Gallary", style: .default) { action -> Void in

                self.handlePhotoLibrary()
            }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
            actionSheetController.addAction(cameraAction)
            actionSheetController.addAction(mediaAction)
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func handleCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        else{
            print("Camera not available0")
        }
       

    }

    func handlePhotoLibrary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)

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
extension ProfileSettingVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imgUser.image = image
            
        }
        else if let image = info[.originalImage] as? UIImage {
            imgUser.image = image
        } else {
            print("Other source")
        }
        isImageUpdated = true
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
