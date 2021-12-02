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
    var photos = [UIImage]()
    let session = Session.instance
    var fullScreenView: UIView?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: galleryCollectionCellNibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
        
        let parametrs: Parameters = [
            "user_ids": session.userId,
            "access_token": session.token,
            "v": "5.131",
            "rev": 1,
            "album_id": "profile"
            
        ]
        
        Alamofire.request("https://api.vk.com/method/photos.get?user_ids=&rev=&album_id=&fields=bdate&v=", parameters: parametrs).responseJSON { data in
            print(data.value)
        }
    
    }
    @IBAction func pressCloseButton(_ sender: UIButton) {
        
        collectionView.isHidden = false
       // self.view.bringSubviewToFront(collectionView)
    }
    
}



