//
//  CustomTableViewCell.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 15.10.2021.
//

import UIKit


protocol CustomTableCellProtocol: AnyObject {
    func customTableCellLikeCounterIncrement(counter: Int)
    func customTableCellLikeCounterDecrement(counter: Int)
}




class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var likeView: LikeCounterView!
    
    
    weak var delegate: CustomTableCellProtocol?
    var completion: ((FriendInfo) -> Void)?
    var friend: FriendInfo?

    
    override func prepareForReuse() {
        avatarImageView.image = nil
        titleLabel.text = nil
        completion = nil
        friend = nil
    }
    
  
    func configure(friend: FriendInfo, completion: ((FriendInfo) -> Void)?) {
        self.completion = completion
        self.friend = friend
        let image = try? Data(contentsOf: URL(string: friend.photo100)!)
        self.avatarImageView.image = UIImage(data: image!)
        titleLabel.text = friend.firstName + " " + friend.lastName
        likeView.delegate = self
    }

    
    func configure(group: GroupsInfo) {
        let image = try? Data(contentsOf: URL(string: group.photo50)!)
        self.avatarImageView.image = UIImage(data: image!)
        titleLabel.text = group.name
        likeView.delegate = self
    }
    
    func configureTest(group: Group) {
        avatarImageView.image = group.avatar
        titleLabel.text = group.title
        likeView.delegate = self
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = CGFloat(cellHeight / 2 - 4)
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        backView.layer.cornerRadius = CGFloat(cellHeight / 2 - 4)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backView.layer.shadowRadius = 4
        backView.layer.shadowOpacity = 0.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAvatarButton(_ sender: Any) {
        
        let scale = CGFloat(10)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.7,
                       options: []) { [weak self] in
            guard let self = self else {return}
            self.backView.frame = CGRect(x: self.backView.frame.origin.x + scale / 4, y: self.backView.frame.origin.y + scale / 4, width: self.backView.frame.width - scale, height: self.backView.frame.height - scale)
        } completion: { [weak self] isSuccessfully in
            guard let self = self else {return}
            if isSuccessfully,
               let friend = self.friend
            {
                self.completion?(friend)
            }
        }

    }
    
    
}



extension CustomTableViewCell: LikeCounterProtocol {
    func likeCounterIncrement(counter: Int) {
        delegate?.customTableCellLikeCounterIncrement(counter: counter)
    }
    
    func likeCounterDecrement(counter: Int) {
        delegate?.customTableCellLikeCounterDecrement(counter: counter)
    }
    
    
}
