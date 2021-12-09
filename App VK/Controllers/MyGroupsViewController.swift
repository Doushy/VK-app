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
    let vkSession = VKSession.instance
    var myGroupsArray = [ItemGroup]()
    
    let realmManager = RealmManagerGroups()
//    func fill() {
//    let group1 = Group(title: "КВН", avatar: UIImage(named: "q1")!)
//    myGroupsArray.append(group1)
//    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fill()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let userID = vkSession.userId
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "access_token", value: vkSession.token),
            URLQueryItem(name: "extended", value: "1")
        ]
         //print(urlConstructor)
        
        let task = session.dataTask(with: urlConstructor.url!) { [weak self] data, response, error in
            guard let data = data else { return }
                        do {
                            let groups = try JSONDecoder().decode(GroupsResponseGroup.self, from: data)
                            
                            print(groups.response.count)
                            self?.myGroupsArray = groups.response.items
                            DispatchQueue.main.async {
                                //self?.formArrayLetter()
                                self?.tableView.reloadData()
                                self?.realmManager.saveData(users: groups.response.items)
                            }
                            
//                                            self?.dataSource = users
//                                            DispatchQueue.main.async {
//                                                self?.tableView.reloadData()
                            //print(users.response.count)
//                                            }
                                        } catch(let error) {
                                          
                                            //print(error)
                                        }
                                    }
       
                                    task.resume()
    }
        

//    func isItemAlreadyInArray(group: Group) -> Bool {
//        return myGroupsArray.contains { sourceGroup in
//            sourceGroup.title == group.title
//        }
//    }
//
//
//
//
//
//    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == fromAllGroupsToMyGroupsSegue,
//           let sourceVC = segue.source as? AllGroupsViewController,
//           let selectedGroup = sourceVC.selectedGroup as? Group
//        {
//            if isItemAlreadyInArray(group: selectedGroup) {return}
//            self.myGroupsArray.append(selectedGroup)
//            tableView.reloadData()
//        }
//    }
//
    
    
    
    
    
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
