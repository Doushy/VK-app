//
//  GalleryViewController+CollectionDataSource.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 19.10.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Photo conunt:\(friendsArray.count)")
        return  self.friendsArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierGalleryCell, for: indexPath) as? GalleryCollectionCell else {return UICollectionViewCell()}
        
       
        cell.configurePhoto(image: friendsArray[indexPath.item])
        
        return cell
    }
    
    
    
    
    
    
}
