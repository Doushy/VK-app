//
//  FriendsViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit
import Alamofire
import RealmSwift
import Realm

class FriendsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let vkSession = VKSession.instance
    let realmManager = RealmManager()
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromFriendsToGallerySegue = "fromFriendsToGallery"
    
    var friendsArray = [FriendInfo]()
    //var savedFriendsArray = [FriendInfo]()
    var arrayLetter = [String]()
    
    
    var token: NotificationToken?
    var dataSource: Results<FriendInfo>?
    var savedFriendsArray: Results<FriendInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //friendsArray = realmManager.getData()
        //fillFriendsArray()
        mathcRealm()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        configureTableView()
        searchBar.delegate = self
        
        
        savedFriendsArray = dataSource
        formArrayLetter()
        
        
        
        
        
        
        //tableView.reloadData()
        
        //makeFriendsRequest()
        
    }
    
    func getImage(from url: String) -> UIImage? {
            var image: UIImage?
            guard let imageURL = URL(string: url) else { return nil }

            guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
            image = UIImage(data: imageData)

            return image
        }
    
    func mathcRealm() {
        let realm = try! Realm()
        dataSource = realm.objects(FriendInfo.self)
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
    
    @IBAction func addFirend(_ sender: Any) {
            makeFriendsRequest()
        }
    
    func makeFriendsRequest() {
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
                let users = try JSONDecoder().decode(Friends.self, from: data)
                let friends = users.response?.items
                
                //self?.friendsArray = Array(frineds!)
                //self?.savedFriendsArray = Array(frineds!)
               
                
                DispatchQueue.main.async {
                    self?.formArrayLetter()
                    self?.tableView.reloadData()
                    self?.realmManager.saveData(data: Array(friends!))
                    print("TEST: Ready")
                    //print("TEST:\(users.response.items.map { $0})")
               }
            } catch(let error) {
                //print(error)
            }
        }
        .resume()
    }
    
    func arrayLetter(sourceArray: Results<FriendInfo>?) -> [String] {
        var resultArray = [String]()
        //print(sourceArray)
        for item in sourceArray! {
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
        arrayLetter = arrayLetter(sourceArray: self.dataSource)
    }
    
    func arrayByLetter(sourceArray: Results<FriendInfo>?, letter: String) -> [FriendInfo] {
        var resultArray = [FriendInfo]()
        for item in sourceArray! {
            let nameLetter = String(item.firstName.prefix(1)).lowercased()
            if nameLetter == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallerySegue,
        
           let destinationVC = segue.destination as? GalleryViewController,
           let friend = sender as? FriendInfo {
            destinationVC.id = friend.id
            //destinationVC.photo100 = friend.photo100
        }
    }
}

    
    
    
    
    
    
    

    


extension FriendsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            self.dataSource = self.savedFriendsArray
//        }
//        else {
//            self.dataSource = self.dataSource.filter({ friendsItem in
//                friendsItem.firstName.lowercased().contains(searchText.lowercased())
//            })
//        }
//        formArrayLetter()
//        self.tableView.reloadData()
//    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}





extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(sourceArray: dataSource, letter: self.arrayLetter[section]).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(friend: arrayByLetter(sourceArray: dataSource, letter: arrayLetter[indexPath.section])[indexPath.row], completion: { [weak self] myFriend in
            guard let self = self else {return}
            self.performSegue(withIdentifier: self.fromFriendsToGallerySegue, sender: myFriend)
            
        })
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter(sourceArray: dataSource)[section].uppercased()
    }
    
}
