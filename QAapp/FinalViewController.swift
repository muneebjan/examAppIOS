//
//  FinalViewController.swift
//  QAapp
//
//  Created by Apple on 15/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    

    private let cellId = "cellId"
    
    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "final_screen_background.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 36)
        label.text = "RESULT"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var answerTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(customCell.self, forCellReuseIdentifier: cellId)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let correctAnswerLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .red
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let retryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = customColor.singleton.greenColor
        button.addTarget(self, action: #selector(retryButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    let questions: [String] = ["Pakistan", "England", "France", "Canada", "China", "Germany", "USA", "UAE", "Russia", "Australia"]
//    let answers = ["Islamabad", "London", "Correct", "Ottawa", "Beijing", "Berlin", "Correct", "Abu Dhabi", "Moscow", "Canberra"]
//    var Data = data.singleton.tableData
    
    
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        answerTableView.tableFooterView = UIView()
        setupView()
    }
    
    func setupView(){
        
        view.addSubview(backgroundImage)
        view.addSubview(answerLabel)
        view.addSubview(answerTableView)
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        answerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        answerTableView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 25).isActive = true
        answerTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        answerTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        answerTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        view.addSubview(retryButton)
        retryButton.topAnchor.constraint(equalTo: answerTableView.bottomAnchor, constant: 5).isActive = true
        retryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        retryButton.leftAnchor.constraint(equalTo: answerTableView.leftAnchor).isActive = true
        retryButton.rightAnchor.constraint(equalTo: answerTableView.rightAnchor).isActive = true
        
        
        
    }
    
    //// OBJECTIVE C FUNCTIONS
    
    @objc func retryButtonHandler(){
        print("retry Pressed")
        self.present(QAscreen(), animated: true, completion: nil)
    }
    
}

//// =======================/ EXTENSIONS \===========================

extension FinalViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.singleton.questions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? customCell
        
        if (data.singleton.correctIncorrectAnswers[indexPath.row] != "Correct"){
            cell?.dataTextLabel.textColor = customColor.singleton.crossColor
            cell?.rightImage.image = UIImage(named: "wrong_big")
        }else{
            cell?.dataTextLabel.textColor = customColor.singleton.greenColor
            cell?.rightImage.image = UIImage(named: "correct_big")
        }
        
        cell!.dataTextLabel.text = data.singleton.questions[indexPath.row]

        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let controller = EndingViewController()
        controller.index = indexPath.row
        
        if (data.singleton.correctIncorrectAnswers[indexPath.row] != "Correct"){
            controller.image = UIImage(named: "wrong_big")!
            controller.answerLabel.text = "Your Answer: \(data.singleton.correctIncorrectAnswers[indexPath.row])"
            controller.correctLabel.text = "Correct Answer: \(data.singleton.apiResponseAnswer[indexPath.row+1])"
            controller.correctLabel.backgroundColor = customColor.singleton.crossColor
        }else{
            controller.image = UIImage(named: "correct_big")!
            controller.answerLabel.text = "Your Answer is: \(data.singleton.correctIncorrectAnswers[indexPath.row])"
            controller.correctLabel.text = "Correct Answer"
            controller.correctLabel.backgroundColor = customColor.singleton.greenColor
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

class customCell: UITableViewCell {
    
    let rightImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "wrong_big")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dataTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.addSubview(cellView)
    

        cellView.topAnchor.constraint(equalTo: (self.topAnchor), constant: 5).isActive = true
        cellView.bottomAnchor.constraint(equalTo: (self.bottomAnchor), constant: -5).isActive = true
        cellView.leftAnchor.constraint(equalTo: (self.leftAnchor), constant: 5).isActive = true
        cellView.rightAnchor.constraint(equalTo: (self.rightAnchor), constant: -5).isActive = true
        
        cellView.addSubview(dataTextLabel)
        dataTextLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        dataTextLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        cellView.addSubview(rightImage)
        rightImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        rightImage.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -5).isActive = true
        rightImage.widthAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.8).isActive = true
        rightImage.heightAnchor.constraint(equalTo: cellView.heightAnchor, multiplier: 0.8).isActive = true
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//extension FinalViewController: HeaderDelegate{
//    func callHeader(idx: Int) {
//        Data[idx].isExpandable = !Data[idx].isExpandable
//        answerTableView.reloadSections([idx], with: .none)
//    }
//
//}


