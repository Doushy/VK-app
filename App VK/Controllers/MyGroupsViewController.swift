//
//  MyGroupsViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit
import Alamofire
import RealmSwift


class MyGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    let vkSession = VKSession.instance
    var myGroupsArray = [GroupsInfo]()
    
    let realmManager = RealmManager()
    
    var token: NotificationToken?
    var dataSource: Results<GroupsInfo>?
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mathcRealm()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
        //myGroupsArray = realmManager.getData()
        //tableView.reloadData()
    }
    
    @IBAction func addFirend(_ sender: Any) {
        makeFriendsRequest()
    }
    
    func mathcRealm() {
        let realm = try! Realm()
        dataSource = realm.objects(GroupsInfo.self)
        //print("TEST \(dataSource?.count)")
        token = dataSource?.observe { [weak self] changes in
            switch changes {
            case let .update(results, deletions, insertions, modifications):
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.endUpdates()
                print("UPDATED")
                
                print(self?.dataSource?.count)
            case .initial:
                self?.tableView.reloadData()
                print("INTITAL")
            case .error(let error):
                print("Error")
                
            }
        }
    }
    
    func makeFriendsRequest() {
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
                let users = try JSONDecoder().decode(Groups.self, from: data)
                let groups = users.response?.items
                
                
                
                DispatchQueue.main.async {
                    //self?.dataSource = Array(groups!)
                    //self?.tableView.reloadData()
                    self?.realmManager.saveData(data: Array(groups!))
                    print("TEST: Ready")
                }
                
            } catch(let error) {
            }
        }
        task.resume()
    }
}


extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: dataSource![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
}
