//
//  MyGroupsViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit
import Alamofire

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    let session = Session.instance
    var myGroupsArray = [Group]()
    
    
    func fill() {
    let group1 = Group(title: "КВН", avatar: UIImage(named: "q1")!)
    myGroupsArray.append(group1)
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fill()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        let parametrs: Parameters = [
            "user_ids": session.userId,
            "access_token": session.token,
            "v": "5.131"
            
        ]
        
        Alamofire.request("https://api.vk.com/method/groups.get?user_ids=&fields=bdate&access_token=&v=", parameters: parametrs).responseJSON { data in
            print(data.value)
        }
    }
        

    func isItemAlreadyInArray(group: Group) -> Bool {
        return myGroupsArray.contains { sourceGroup in
            sourceGroup.title == group.title
        }
    }
    
    
    
    
    
    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToMyGroupsSegue,
           let sourceVC = segue.source as? AllGroupsViewController,
           let selectedGroup = sourceVC.selectedGroup as? Group
        {
            if isItemAlreadyInArray(group: selectedGroup) {return}
            self.myGroupsArray.append(selectedGroup)
            tableView.reloadData()
        }
    }
    
    
    
    
    
    
}


extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: myGroupsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
}
