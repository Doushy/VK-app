//
//  GalleryViewController+CollectioDelegate.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 19.10.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       showView(image: self.photos[indexPath.item])

//        backView.isHidden = false
//        collectionView.isHidden = true
//        //self.view.bringSubviewToFront(backView)
        // imageView.image = self.photos[indexPath.item]
    }
    
    
    
}
