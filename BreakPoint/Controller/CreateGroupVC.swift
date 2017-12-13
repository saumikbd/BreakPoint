//
//  CreateGroupVC.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 13/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        doneButton.isHidden = true
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        emailArray = []
        if emailSearchTextField.text == "" {
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forQuery: emailSearchTextField.text!, completion: { (emailArray) in
                self.emailArray = emailArray
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextField.text != "" {
        DataService.instance.getUid(emailArray: chosenUserArray) { (membersArray) in
            var members = membersArray
            members.append((Auth.auth().currentUser?.uid)!)
            DataService.instance.uploadGroup(withTitle: self.titleTextField.text!, Description: self.descriptionTextField.text! , andUids: members, completion: { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        }
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.updateCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.updateCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLabel.text!){
            chosenUserArray.append(cell.emailLabel.text!)
            groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            cell.showing = true
            doneButton.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if chosenUserArray.count > 0 {
                groupMemberLabel.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
            cell.showing = false
        }
    }
}
