//
//  ResultViewController.swift
//  QAapp
//
//  Created by Muneeb on 11/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "backgroundResult.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = customColor.singleton.grayColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "trophy_passed_big.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 32)
        label.text = "Score 17"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let retryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "retry_big.png"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(retryButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "next_big.png"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(nextButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //// OBJECTIVE C FUNCTIONS
    
    @objc func retryButtonHandler(){
        print("retry Pressed")
        
        data.singleton.correctIncorrectAnswers.removeAll()
        data.singleton.questionAnswerMergeArray.removeAll()
        self.show(QAscreen(), sender: self)
//        self.show(ScanImageAndShowQA(), sender: self)
        
    }
    
    @objc func nextButtonHandler(){
        print("next Pressed")
        self.show(FinalViewController(), sender: self)
        
    }
    
    
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Correct Answers Array: \(data.singleton.correctAnswers)")
        print("Total no. of correct answers: \(data.singleton.totalCorrect)")
        print("Wrong answers array: \(data.singleton.wrongAnswers)")
        print("correct Incorrect Array: \(data.singleton.correctIncorrectAnswers)")
        
        
//        data.singleton.correctIncorrectAnswers.remove(at: 0)
//        print("correct Incorrect Array: \(data.singleton.correctIncorrectAnswers)")

        
//        for index in 0..<data.singleton.questions.count {
//            
//            data.singleton.tableData.append(dataModel(headername: data.singleton.questions[index], subType: data.singleton.correctIncorrectAnswers[index], isexpandable: false))
//            
//        }
        
        
        if let count = data.singleton.totalCorrect{
            if count <= 4{
                resultImageView.image = UIImage(named: "trophy_failed.png")
            }else{
                resultImageView.image = UIImage(named: "trophy_passed_big.png")
            }
        }
        
        self.scoreLabel.text = "Score: \(data.singleton.totalCorrect!)"
        
        setupView()
    }

    func setupView(){
        
        view.addSubview(backgroundImage)
        view.addSubview(containerView)
        containerView.addSubview(resultImageView)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(retryButton)
        containerView.addSubview(nextButton)
        
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
        
        resultImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        resultImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
        resultImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
        resultImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
//        resultImageView.backgroundColor = .red
        
        scoreLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: 15).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        lineView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20).isActive = true
        lineView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        retryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        retryButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.425).isActive = true
        retryButton.leftAnchor.constraint(equalTo: lineView.leftAnchor).isActive = true
        retryButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
        
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalTo: retryButton.widthAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo: lineView.rightAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: retryButton.bottomAnchor).isActive = true
        
        
    }
    
}
