//
//  CommunityVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 2021-08-10.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommunityVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        post()
        // Do any additional setup after loading the view.
    }
    func post() {
        if let uid = Auth.auth().currentUser?.uid{
            let post = Community(uid: uid, type: PostType.text.rawValue, content: "Hello", date: "\(Date().timeIntervalSince1970)")
            let ref = Database.database().reference().child("Community").childByAutoId().setValue(post)
        }
    }
    
}
extension CommunityVC  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CommunityTVC
        return cell
    }
    
    
}
