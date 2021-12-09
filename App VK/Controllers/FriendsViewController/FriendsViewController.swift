//
//  FriendsViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromFriendsToGallerySegue = "fromFriendsToGallery"
    var friendsArray = [Item]()
    var savedFriendsArray = [Item]()
    var arrayLetter = [String]()
    let vkSession = VKSession.instance
    var dataSource: [ServerResponse] = []
    
    let realmManager = RealmManagerFriends()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fillFriendsArray()
        formArrayLetter()
        savedFriendsArray = friendsArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        searchBar.delegate = self
        
        configureTableView()
        
        

        let userID = vkSession.userId
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "access_token", value: vkSession.token),
            URLQueryItem(name: "fields", value: "photo_100")
        ]
         //print(urlConstructor)
        
        let task = session.dataTask(with: urlConstructor.url!) { [weak self] data, response, error in
            guard let data = data else { return }
                        do {
                            let users = try JSONDecoder().decode(ServerResponse.self, from: data)
                            
                            print(users.response.count)
                            self?.friendsArray = users.response.items
                            self?.savedFriendsArray = users.response.items
                            DispatchQueue.main.async {
                                self?.formArrayLetter()
                                self?.tableView.reloadData()
                                self?.realmManager.saveData(users: users.response.items)
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
    
    
    
    
    func arrayLetter(sourceArray: [Item]) -> [String] {
        var resultArray = [String]()
        for item in sourceArray {
            let nameLetter = String(item.firstName.prefix(1))
            if !resultArray.contains(nameLetter.lowercased()) {
                resultArray.append(nameLetter.lowercased())
            }
        }
        return resultArray.sorted { firstItem, secondItem in
            firstItem < secondItem
        }
    }
    
    
    func formArrayLetter() {

        arrayLetter = arrayLetter(sourceArray: self.friendsArray)
    }
    
    
    
    func arrayByLetter(sourceArray: [Item], letter: String) -> [Item] {
        var resultArray = [Item]()
        for item in sourceArray {
            let nameLetter = String(item.firstName.prefix(1)).lowercased()
            if nameLetter == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallerySegue,
           //           let sourceVC = segue.source as? FriendsViewController,
           let destinationVC = segue.destination as? GalleryViewController,
           let friend = sender as? Item {
            destinationVC.id = friend.id
            //destinationVC.photo100 = friend.photo100
        }
    }
}


extension FriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.friendsArray = self.savedFriendsArray
        }
        else {
            self.friendsArray = self.friendsArray.filter({ friendsItem in
                friendsItem.firstName.lowercased().contains(searchText.lowercased())
            })
        }
        formArrayLetter()
        self.tableView.reloadData()
    }
    
    func configureTableView() {
           tableView.delegate = self
           tableView.dataSource = self
        }
}





extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return friendsArray.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
//            cell.configure(friend: arrayByLetter(sourceArray: friendsArray, letter: arrayLetter[indexPath.section])[indexPath.row], completion: { [weak self] myFriend in
//                guard let self = self else {return}
//                self.performSegue(withIdentifier: self.fromFriendsToGallerySegue, sender: myFriend)
//            })
//
//        cell.titleLabel.text = friendsArray[indexPath.row].firstName
//            return cell
//        }
//
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(sourceArray: friendsArray, letter: self.arrayLetter[section]).count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(friend: arrayByLetter(sourceArray: friendsArray, letter: arrayLetter[indexPath.section])[indexPath.row], completion: { [weak self] myFriend in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.fromFriendsToGallerySegue, sender: myFriend)
            
        })
        return cell
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter(sourceArray: friendsArray)[section].uppercased()
    }
   
}
