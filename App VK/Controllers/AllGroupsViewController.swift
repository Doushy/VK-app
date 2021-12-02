//
//  AllGroupsViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit
import Alamofire

class AllGroupsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    let session = Session.instance
    
    var allGroupsArray = [Group]()
    
    var count = Int()
    
    var selectedGroup: Group?
    
    func fill() {
        let group1 = Group(title: "КВН", avatar: UIImage(named: "q1")!)
        let group2 = Group(title: "Comedy", avatar: UIImage(named: "q2")!)
        let group3 = Group(title: "Audi", avatar: UIImage(named: "q3")!)
        let group4 = Group(title: "Swift", avatar: UIImage(named: "q4")!)
        allGroupsArray.append(group1)
        allGroupsArray.append(group2)
        allGroupsArray.append(group3)
        allGroupsArray.append(group4)
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
        
        Alamofire.request("https://api.vk.com/method/groups.getCatalog?user_ids=&fields=bdate&access_token=&v=", parameters: parametrs).responseJSON { data in
            print(data.value)
        }
    }
        

}


extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: allGroupsArray[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGroup = allGroupsArray[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToMyGroupsSegue, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}

extension AllGroupsViewController: CustomTableCellProtocol {
    func setCurrentCount(count: Int) {
        self.count = count
    }
    
    func customTableCellLikeCounterIncrement(counter: Int) {
        print(String(counter))
    }
    
    func customTableCellLikeCounterDecrement(counter: Int) {
        print(String(counter))
    }
    
    
}
