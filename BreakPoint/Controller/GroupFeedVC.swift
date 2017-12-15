//
//  GroupFeedVCViewController.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 14/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var group: Group?
    var messageArray = [Message]()
    
    
    func initData(group: Group){
        self.group = group
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupFeedTableView.delegate = self
        groupFeedTableView.dataSource = self
        
        tableHeight.constant = view.bounds.size.height - 180
        stackView.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chatTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func chatTap() {
        self.view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.title
        DataService.instance.getEmails(uidArray: (group?.members)!) { (emailArray) in
            self.membersLabel.text = emailArray.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroupMessages(groupkey: (self.group?.key)!, completion: { (messages) in
                self.messageArray = messages
                self.groupFeedTableView.reloadData()
                if self.messageArray.count > 0 {
                    self.groupFeedTableView.scrollToRow(at: IndexPath(row: self.messageArray.count-1, section: 0) , at: .bottom, animated: false)
                }
            })
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        sendButton.isEnabled = false
        if messageTextField.text != "" {
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forId: (Auth.auth().currentUser?.uid)!, withGroupKey: (self.group?.key)!, completion: { (success) in
                if success {
                    self.sendButton.isEnabled = true
                    self.messageTextField.text = ""
                    self.groupFeedTableView.reloadData()
                }
            })
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismissDetail()
    }
}
extension GroupFeedVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupFeedTableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else {return UITableViewCell()}
        
        DataService.instance.getUsername(uid: messageArray[indexPath.row].senderId) { (email) in
            cell.updateCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: email, message: self.messageArray[indexPath.row].content)
        }
        return cell
    }
}
