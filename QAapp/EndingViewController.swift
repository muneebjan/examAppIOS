//
//  EndingViewController.swift
//  QAapp
//
//  Created by Apple on 29/08/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    var index = Int()
    var textLabel = String()
    var image = UIImage()
//    var correct = String()
    
    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "final_screen_background.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
//        label.text = "Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circleImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "wrong_big.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = 35
        return imageview
    }()
    

    
    let correctLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = customColor.singleton.greenColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        print("printing index: \(index)")
        circleImage.image = self.image
        
        setupView()
    }
    
    func setupView(){
        
        view.addSubview(backgroundImage)
        view.addSubview(containerView)
        view.addSubview(topContainerView)
        containerView.addSubview(answerLabel)
        containerView.addSubview(correctLabel)
        topContainerView.addSubview(circleImage)
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        answerLabel.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 10).isActive = true
        answerLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.35).isActive = true
        answerLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        answerLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        
        topContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -40).isActive = true
        topContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        topContainerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        circleImage.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        circleImage.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        circleImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        circleImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
//        correctLabel.text = "Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text Dummy text "
        correctLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        correctLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        correctLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        correctLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
}
