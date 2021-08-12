//
//  CommentTV.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 2021-08-12.
//

import UIKit

class CommentTV: UIViewController {
    var arrComments =  ["wow amazing","nice","what a transformation","congrats"]
    var arrUsers = [User]()
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handlePost(_ sender: Any) {
        arrComments.append(txtComment.text ?? "")
        txtComment.text = ""
        tableView.reloadData()
        
        
    }
}
extension CommentTV : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CommentTVC
        cell.lblComment.text = arrComments[indexPath.row]

        if arrUsers.count > 0{
            
                cell.imgProfile.sd_setImage(with: URL(string:arrUsers[0].picture), completed: nil)
                cell.lblName.text = arrUsers[0].name
            
            
        }
        
        return cell
    }
    
}

class CommentTVC: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.contentMode = .scaleAspectFill
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.borderColor = Constants.ThemePink.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        imgProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
