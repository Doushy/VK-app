//
//  NewsTableViewCell.swift
//  App VK
//
//  Created by Дима Сторчеус on 16.11.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    


    @IBOutlet var newsAvatarImageView: UIImageView!
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    
    var likeEnable = false
    var counter = 0
    
    override func prepareForReuse() {
        newsAvatarImageView.image = nil
        newsTitleLabel.text = nil
        likeEnable = false
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func configure(news: News) {
        newsAvatarImageView.image = news.avatarNews
        newsTitleLabel.text = news.textNews
    }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
