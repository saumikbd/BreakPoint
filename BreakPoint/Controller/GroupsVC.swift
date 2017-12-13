//
//  SecondViewController.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 10/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var groupsTableView: UITableView!
    
    var groups = [Group]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getGroups { (groups) in
                self.groups = groups
                self.groupsTableView.reloadData()
            }
        }
    }
}
extension GroupsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell()}
        cell.updateCell(title: groups[indexPath.row].title, description: groups[indexPath.row].description, memberNumber: groups[indexPath.row].membersCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {return}
        groupFeedVC.initData(group: groups[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
    }
    
}
