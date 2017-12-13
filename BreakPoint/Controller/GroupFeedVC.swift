//
//  GroupFeedVCViewController.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 14/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var textEditingView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupFeedTableView.delegate = self
        groupFeedTableView.dataSource = self
        
        textEditingView.bindToKeyboard()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension GroupFeedVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupFeedTableView.dequeueReusableCell(withIdentifier: "groupFeedCell") as? GroupFeedCell else {return UITableViewCell()}
        cell.updateCell(profileImage: #imageLiteral(resourceName: "defaultProfileImage"), email: "shakib@alhasan.com", message: "how are you?")
        return cell
    }
}
