//
//  EditingViewController.swift
//  QAapp
//
//  Created by Apple on 31/08/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    // VARIABLES
    var text = String()
    var index = Int()
    
    // OUTLETS
    let editTextfield: UITextField = {
        let tf = UITextField()
        tf.layer.cornerRadius = 10
        tf.textAlignment = .center
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(customColor.singleton.orangeColor, for: .normal)
        button.backgroundColor = .white //customColor.singleton.greenColor
        button.addTarget(self, action: #selector(saveButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
        
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        print("printing data: \(text)")
        
        editTextfield.text = text
        
        self.setupView()
        
    }

    fileprivate func setupView(){
        
        view.addSubview(editTextfield)
        editTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let centerY = NSLayoutConstraint(item: editTextfield, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.7, constant: 0)
        NSLayoutConstraint.activate([centerY])
        editTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: editTextfield.bottomAnchor, constant: 10).isActive = true
        saveButton.widthAnchor.constraint(equalTo: editTextfield.widthAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: editTextfield.centerXAnchor).isActive = true
        
        
    }
    
    
    @objc func saveButtonHandler(){
        print("\(self.editTextfield.text)")
        
        
        let removeString = data.singleton.questionAnswerMergeArray.remove(at: self.index)
        
        
        if removeString.first == "Q"{
            print("here1")
            data.singleton.questionAnswerMergeArray.insert("Q: \(self.editTextfield.text!)", at: self.index)
        } else if removeString.first == "A"{
            print("here2")
            data.singleton.questionAnswerMergeArray.insert("A: \(self.editTextfield.text!)", at: self.index)
        }
        
            
        self.navigationController?.popViewController(animated: true)
    }
    
}

