//
//  FriendsViewController+CollectionDataSource.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 21.10.2021.
//

import UIKit


//extension FriendsViewController: UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return arrayLetter.count
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayByLetter(sourceArray: friendsArray, letter: self.arrayLetter[section]).count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
//        cell.configure(friend: arrayByLetter(sourceArray: friendsArray, letter: arrayLetter[indexPath.section])[indexPath.row], completion: { [weak self] myFriend in
//            guard let self = self else {return}
//            self.performSegue(withIdentifier: self.fromFriendsToGallerySegue, sender: myFriend)
//        })
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return arrayLetter(sourceArray: friendsArray)[section].uppercased()
//    }
//
//
//}
