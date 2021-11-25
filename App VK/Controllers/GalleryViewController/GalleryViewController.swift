//
//  GalleryViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 19.10.2021.
//

import UIKit


class GalleryViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    var photos = [UIImage]()
    
    var fullScreenView: UIView?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: galleryCollectionCellNibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
    
    }
    @IBAction func pressCloseButton(_ sender: UIButton) {
        
        collectionView.isHidden = false
       // self.view.bringSubviewToFront(collectionView)
    }
    
}



