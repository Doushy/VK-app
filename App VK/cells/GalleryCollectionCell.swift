//
//  GalleryCollectionCell.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 19.10.2021.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    
    var likeEnable = false
    var counter = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        likeEnable = false
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    
    func configurePhoto(image: ItemPhotes) {
        
        var image = try? Data(contentsOf: URL(string: image.sizes.first!.url)!)
        photoImageView.image = UIImage(data: image!)

        //likeView.delegate = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func pressHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if likeEnable {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            counter -= 1
            likeCounter.text = String(counter)
        }
        else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            counter += 1
            likeCounter.text = String(counter)
        }
        likeEnable = !likeEnable
    }
}
