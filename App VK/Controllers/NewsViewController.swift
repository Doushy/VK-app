//
//  NewsViewController.swift
//  App VK
//
//  Created by Дима Сторчеус on 16.11.2021.
//

import UIKit

class NewsViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    var newsArray = [News]()
    
    func fillNewsArray() {
        let news1 = News(textNews: "привет", avatarNews: UIImage(named: "q1")!)
        let news2 = News(textNews: "как дела", avatarNews: UIImage(named: "q2")!)
        let news3 = News(textNews: "что делаешь", avatarNews: UIImage(named: "q3")!)
        let news4 = News(textNews: "пока", avatarNews: UIImage(named: "q4")!)
        newsArray.append(news1)
        newsArray.append(news2)
        newsArray.append(news3)
        newsArray.append(news4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNewsArray()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
        
        
        
        
        
    }
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        cell.configure(news: newsArray[indexPath.row])
        
        return cell
        
    }
    
    
}


