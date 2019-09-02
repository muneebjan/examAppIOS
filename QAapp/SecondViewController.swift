//
//  SecondViewController.swift
//  QAapp
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //// UI OBJECTS
    
    let imageTobeShown: UIImageView = {
        let imageview = UIImageView()
        //        imageview.image = UIImage(named: "logo2.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        return button
    }()
    
    
    //// VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        self.setupViews()
        
    }
    
    //// PRIVATE FUNCTIONS
    
    fileprivate func setupViews() {
        
        view.addSubview(imageTobeShown)
        
        imageTobeShown.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageTobeShown.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageTobeShown.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageTobeShown.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        //        imageTobeShown.backgroundColor = .orange
        
        
        view.addSubview(doneButton)
        doneButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        doneButton.leftAnchor.constraint(equalTo: imageTobeShown.leftAnchor, constant: 10).isActive = true
        doneButton.rightAnchor.constraint(equalTo: imageTobeShown.rightAnchor, constant: -10).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: imageTobeShown.bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    private func gettingDataFromApi(){
        
        let imageurl = "https://i.ibb.co/t8NjJCY/11.jpg"
        
//        let imageurl = "https://s3.us-east-2.amazonaws.com/quizexam/Image_588691588.181878.png"
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        AuthServices.instance.updateImageURLtoDatabase(imageURL: imageurl) { (success) in
            if(success){
                print("api successfull")
                UIViewController.removeSpinner(spinner: sv)
                self.navigationController?.pushViewController(ScanImageAndShowQA(), animated: true)
            }else{
                print("not successfull")
                UIViewController.removeSpinner(spinner: sv)
            }
        }
        
    }
    
    //// OBJECTIVE C FUNCTIONS
    // MARK: - DoneButton
    @objc func doneButtonHandler(){
        print("done button pressed")
        gettingDataFromApi()
    }
    
}
