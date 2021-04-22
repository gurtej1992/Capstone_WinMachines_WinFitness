//
//  LoginVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by user194393 on 4/14/21.
//

import UIKit
import Firebase
import FBSDKLoginKit
import TwitterKit


class LoginVC: UIViewController {
    //Outlets for Login
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewLoginHeight: NSLayoutConstraint!
    // Outlets for Signup
    @IBOutlet weak var stackViewSignup: UIStackView!
    @IBOutlet weak var txtSemail: UITextField!
    @IBOutlet weak var txtSpass: UITextField!
    @IBOutlet weak var txtSname: UITextField!
    @IBOutlet weak var txtSconfirmPass: UITextField!
    // Variables
    var comeForLogin = true
    typealias Dic = [String:Any]
   // var swifter : Swifter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        // facebookLogin()
        
    }
    func prepareUI(){
        if comeForLogin{
            stackViewSignup.isHidden = true
            viewLoginHeight.constant = (view.frame.height * 40) / 100
            viewLogin.isHidden = false
        }
        else{
            stackViewSignup.isHidden = false
            viewLoginHeight.constant = 0
            viewLogin.isHidden = true
        }
    }
    func pushUserInfoInFirebase(email : String,name: String, picture:String? = "",uid :String){
        let ref = Database.database().reference()
        let userDic = ["email":email,"name":name,"day":"1","picture":picture ?? ""] as Dic
        ref.child("Users").child(uid).setValue(userDic) { (error, _) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: Constants.segToHome, sender: self)
        }

    }
    @IBAction func handleNotRegistered(_ sender: Any) {
        comeForLogin = false
        prepareUI()
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleTwitterLogin(_ sender: Any) {
        TWTRTwitter.sharedInstance().logIn { (session, err) in
            if err != nil {
                print(err?.localizedDescription ?? "oops")
                return
            }
            let twitterClient = TWTRAPIClient(userID: session?.userID)
            twitterClient.loadUser(withID: (session?.userID)!) { (user, err) in
                if err != nil {
                    print(err?.localizedDescription ?? "oops")
                    return
                }
                let credentials = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credentials) { [weak self](auth, error) in
                    guard let strongSelf = self else { return }
                    if error != nil{
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    strongSelf.pushUserInfoInFirebase(email: user!.screenName, name: user!.name,picture: user?.profileImageLargeURL, uid: auth!.user.uid)
                }
            }
        }
    }
    @IBAction func handleLogIn(_ sender: Any) {
        
        guard let pass = txtPass.text else {return}
        guard let email = txtEmail.text else {return}
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] auth, error in
            guard let strongSelf = self else { return }
            if error != nil{
                print(error?.localizedDescription ?? "")
                return
            }
            strongSelf.performSegue(withIdentifier: Constants.segToHome, sender: strongSelf)
        }
    }
    @IBAction func handleSignUp(_ sender: Any) {
        guard let email = txtSemail.text else {return}
        guard let name = txtSname.text else {return}
        guard let pass = txtSpass.text else {return}
        guard let confirm = txtSconfirmPass.text else {return}
        if confirm == pass {
            Auth.auth().createUser(withEmail: email, password: pass) { [weak self](auth, error) in
                guard let strongSelf = self else { return }
                if error != nil{
                    print(error?.localizedDescription ?? "")
                    return
                }
                strongSelf.pushUserInfoInFirebase(email: email, name: name, uid: auth!.user.uid)
            }
        }
        else{
            print("Password not matched")
        }
    }
    @IBAction func handleFBLogin(_ sender: Any) {
        
        // 1
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            loginManager.logOut()
            
        } else {
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                let token = result.token?.tokenString
                
                let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, picture.type(normal), name"], tokenString: token, version: nil, httpMethod: .get)
                request.start { (connection, result, error) in
                    if let userData = result as? [String:Any]{
                        let name = userData["name"] as! String
                        let email = userData["email"] as! String
                        let picture = ((userData["picture"] as! [String:Any])["data"] as! [String:Any])["url"] as! String
                        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                        Auth.auth().signIn(with: credential) { [weak self](auth, error) in
                            guard let strongSelf = self else { return }
                            if error != nil{
                                print(error?.localizedDescription ?? "")
                                return
                            }
                            strongSelf.pushUserInfoInFirebase(email: email, name: name,picture: picture, uid: auth!.user.uid)
                        }
                    }
                }
            }
        }
    }
}
