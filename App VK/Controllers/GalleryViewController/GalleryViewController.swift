//
//  GalleryViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 19.10.2021.
//

import UIKit
import Alamofire

class GalleryViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    var photo100 = [UIImage]()
    var id = Int()
    let vkSession = VKSession.instance
    var fullScreenView: UIView?
    var friendsArray = [PhotesSize]()
    //var datatest: [PhotesSize] = []
 
//    let realmManager = RealmManagerPhotos()
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: galleryCollectionCellNibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
        
        //friendsArray = realmManager.getData()
        //print(friendsArray)
        //collectionView.reloadData()
                makeFriendsRequest()
        
        
        
        
        
        
        func makeFriendsRequest() {
        let userID = vkSession.userId
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "access_token", value: vkSession.token),
            URLQueryItem(name: "rev", value: "1"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "owner_id", value: String(id))
            
        ]
         print(urlConstructor)
        
        let task = session.dataTask(with: urlConstructor.url!) { [weak self] data, response, error in
            guard let data = data else { return }
                        do {
                            let users = try JSONDecoder().decode(Photes.self, from: data)
                            
                            
                            self?.friendsArray = users.response.items
//                            print(users.response.items)
                            print(urlConstructor)
                            DispatchQueue.main.async {
                                //print(users.response.count)
                                
                                users.response.items.forEach { sizes in
                                    self?.realmManager.saveData(data: sizes.sizes)
                                    print(sizes.sizes)
                                    //self?.datatest = [sizes]
                                }
//                                self?.realmManager.saveData(users: users.response.items)
                                self?.collectionView.reloadData()
                                
                                
                            }
                            

                                        } catch(let error) {
                                          
                                            print(error)
                                        }
                                    }
       
                                    task.resume()
        

        }
    }
    
    @IBAction func pressCloseButton(_ sender: UIButton) {
        
        collectionView.isHidden = false
       // self.view.bringSubviewToFront(collectionView)
    }
}



