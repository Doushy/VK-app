//
//  File.swift
//  App VK
//
//  Created by Дима Сторчеус on 12.11.2021.
//

import UIKit

extension GalleryViewController {
    
    func showView(image: UIImage) {
        if fullScreenView == nil {
            fullScreenView = UIView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }
        
        fullScreenView!.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        self.view.addSubview(fullScreenView!)
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
//        fullScreenView?.addGestureRecognizer(tapRecognizer)
        
        let imageView = UIImageView(image: image)
        fullScreenView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: fullScreenView!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: fullScreenView!.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        
//       let closeButton = UIButton(frame: CGRect(x: fullScreenView!.bounds.width - 40, y: 0, width: 40, height: 40), primaryAction: UIAction()
        
                                   
        //Swift передача данных между контроллерами
                                   
                                   
                                   
                                   
                                   
        let closeButton = UIButton(frame: CGRect(x: fullScreenView!.bounds.width - 40, y: 0, width: 40, height: 40))
        closeButton.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        closeButton.layer.cornerRadius = 20
      closeButton.addAction(UIAction(handler: { [weak self] _ in
          self?.fullScreenView?.subviews.forEach({ view in
                        view.removeFromSuperview()
                    })
          self?.fullScreenView!.removeFromSuperview()
        }), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "multiply"), for: .normal)
//
//
       fullScreenView?.addSubview(closeButton)
//
        
        
    }
    
    
    @objc func onTap() {
        guard let fullScreenView = self.fullScreenView else {return}
        fullScreenView.removeFromSuperview()
    }

    
    
    
}

