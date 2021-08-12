//
//  CommunityVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 2021-08-10.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage
class CommunityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrUsers = [User]()
    var arrCommunity = [Community]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // post()
        fetchWall()
        // Do any additional setup after loading the view.
    }
    func fetchWall(){
        let _ = Database.database().reference().child("Community").observe(.value) { (snapshot) in
            if snapshot.exists(){
                for (index, snap) in snapshot.children.enumerated() {
                    let userSnap = snap as! DataSnapshot
                    //let uid = userSnap.key //the uid of each user
                    let userDict = userSnap.value as! [String:AnyObject] //child data
                    let uid = userDict["uid"] as! String
                    let com = Community(uid: uid, type: userDict["type"] as! String, content: userDict["content"] as! String, date: userDict["date"] as! String)
                    
                    
                    let _ = Database.database().reference().child("Users").child(uid).observe(.value) { (snap) in
                        if snap.exists(){
                            let snapshot = snap.value as! [String:Any]
                            let user = User(email: snapshot["email"] as? String, name: snapshot["name"] as? String, picture: snapshot["picture"] as? String ?? "", height: snapshot["height"] as? String ?? "", weight: snapshot["weight"] as? String ?? "", dob: snapshot["dob"] as? String ?? "", day: snapshot["day"] as? Int ?? 1)
                            self.arrUsers.append(user)
                            self.arrCommunity.append(com)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
    func post() {
        if let uid = Auth.auth().currentUser?.uid{
            let post = ["uid":uid,"type":PostType.image.rawValue, "content": "https://i2-prod.mirror.co.uk/incoming/article11291979.ece/ALTERNATES/s615b/PAY-Binging-To-Bodybuilding.jpg", "date": "\(Date().timeIntervalSince1970)"] as [String:Any]
            Database.database().reference().child("Community").childByAutoId().setValue(post)
        }
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension CommunityVC  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCommunity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CommunityTVC
        cell.btn.tag = indexPath.row
        cell.btnLike.tag = indexPath.row
        cell.imgCell.sd_setImage(with: URL(string:arrCommunity[indexPath.row].content), completed: nil)
        cell.imgProfile.sd_setImage(with: URL(string:arrUsers[indexPath.row].picture), completed: nil)
        cell.lblName.text = arrUsers[indexPath.row].name
        let date = Date(timeIntervalSince1970: TimeInterval(arrCommunity[indexPath.row].date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        cell.lblTime.text = formatter.localizedString(for: date, relativeTo: Date())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
