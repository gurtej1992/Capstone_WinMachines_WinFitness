//
//  ProgressVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 4/18/21.
//

import UIKit
import PopupDialog

class ProgressVC: UIViewController {
    
    @IBOutlet weak var imgAfter: UIImageView!
    @IBOutlet weak var imgBefore: UIImageView!
    @IBOutlet weak var viewToBlur: UIView!
    @IBOutlet weak var lblImagePrev: UILabel!
    var isSelectBeforeImage = false
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewToBlur.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToBlur.addSubview(blurEffectView)
    }
    @IBAction func handleDone(_ sender: Any) {
        let bottomImage = imgBefore.image
        let topImage = imgAfter.image

        let size = CGSize(width: 300, height: 300)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        bottomImage!.draw(in: areaSize)

        topImage!.draw(in: areaSize, blendMode: .normal, alpha: 0.8)

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
        
        let title = "Success"
        let message = "Progress pic has been created successfully and saved to photos."
        let popup = PopupDialog(title: title, message: message)
        let buttonOne = CancelButton(title: "Okay") {
            print("You canceled the car dialog.")
        }
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleChangeAfter(_ sender: Any) {
        isSelectBeforeImage = false
        callAddImage()
    }
    @IBAction func handleChangeBefore(_ sender: Any) {
        isSelectBeforeImage = true
        callAddImage()
    }
    func callAddImage(){
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
}
extension ProgressVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            if isSelectBeforeImage{
                imgBefore.image = image
            }
            else{
                imgAfter.image = image
            }
        }
        else if let image = info[.originalImage] as? UIImage {
            if isSelectBeforeImage{
                imgBefore.image = image
            }
            else{
                imgAfter.image = image
            }
        } else {
            print("Other source")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
