//
//  LoginViewController.swift
//  VKClientGroup9
//
//  Created by Rodion Molchanov on 08.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var firstRoundView: UIView!
    @IBOutlet var secondRoundView: UIView!
    @IBOutlet var thirdRoundView: UIView!
    
    
    
    
    
    
    
    func addShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        firstRoundView.alpha = 0
        secondRoundView.alpha = 0
        thirdRoundView.alpha = 0
        
        dotsAnimateKeyframe(exitAfter: 3, currentCount: 0)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.27588135, green: 0.5855496526, blue: 0.8788650632, alpha: 1).cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.8, 1]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.view.bounds
       // gradientLayer.cornerRadius = 12
        gradientLayer.zPosition = -1
        self.view.layer.addSublayer(gradientLayer)
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.view.addGestureRecognizer(tapRecognizer)
        
        addShadow(view: loginTextField)
        addShadow(view: passwordTextField)
        addShadow(view: loginButton)
        
        loginButton.layer.cornerRadius = 10
     }
    
    
    @objc func tapFunction() {
        self.view.endEditing(true)
    }
    
    

    
    
    
    
    
    
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let session = Session.instance
            session.token = "#453"
            session.userId = 11221326
        
//        guard let login = loginTextField.text,
//              let password = passwordTextField.text
//        else {return}
       
//        if login == "root",
//           password == "123" {
//            print("login success")
//            loginTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//            passwordTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            performSegue(withIdentifier: "toGreenSegue", sender: nil)
//        }
//        else {
//            loginTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//            passwordTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//            return
//        }
    }
    
    func dotsAnimateKeyframe(exitAfter: Int, currentCount: Int) {
        UIView.animateKeyframes(withDuration: 1.2,
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.333333333) {[weak self] in
                self?.firstRoundView.alpha = 1
                self?.thirdRoundView.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.333333333,
                               relativeDuration: 0.333333333) {[weak self] in
                self?.firstRoundView.alpha = 0
                self?.secondRoundView.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.66666666,
                               relativeDuration: 0.333333334) {[weak self] in
                self?.secondRoundView.alpha = 0
                self?.thirdRoundView.alpha = 1
            }
        
          
        } completion: { [weak self] _ in
            if currentCount < exitAfter {
                self?.dotsAnimateKeyframe(exitAfter: exitAfter, currentCount: currentCount + 1)
                self?.thirdRoundView.alpha = 0
            }
            else {
                
            }
        }
    }
}
