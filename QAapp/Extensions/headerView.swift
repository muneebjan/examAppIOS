//
//  headerView.swift
//  QAapp
//
//  Created by Apple on 16/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

protocol HeaderDelegate {
    func callHeader(idx: Int)
}

class headerView: UIView {
    
    var secIndex: Int?
    var delegate: HeaderDelegate?
    
    lazy var image: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: self.frame.origin.x + self.frame.size.width - 10, y: self.frame.origin.y + 7.5, width: -(self.frame.size.height), height: self.frame.size.height - 15))
        imageview.image = UIImage(named: "correct_big.png")
//        imageview.backgroundColor = .red
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.height, height: self.frame.size.height))
        label.backgroundColor = .clear
        label.text = "1"
        label.textAlignment = .center
        label.textColor = customColor.singleton.tickColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var headerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height))
//        let button = UIButton()
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(onClickHeader), for: .touchUpInside)
        button.setTitleColor(customColor.singleton.tickColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headerButton)
        self.addSubview(countLabel)
        self.addSubview(image)
        
//        countLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
//        headerButton.leftAnchor.constraint(equalTo: countLabel.rightAnchor, constant: 20).isActive = true
//        headerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc func onClickHeader(){
        print("header pressed")
        if let idx = secIndex{
            delegate?.callHeader(idx: idx)
        }
        
    }
    
    
}
