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
        label.font = UIFont(name: "Roboto-Bold", size: 38)
        label.text = "FINAL"
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
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
    
//    let cellView = cellViews()
    
    var Data = data.singleton.tableData
//    var Data = [dataModel(headername: "Islamabad", subType: ["Correct"], isexpandable: false),
//                dataModel(headername: "Lahore", subType: ["incorrect"], isexpandable: false),
//                dataModel(headername: "Peshawar", subType: ["Correct"], isexpandable: false),
//                dataModel(headername: "Gujrat", subType: ["Correct"], isexpandable: false)]
    
    
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTableView.tableFooterView = UIView()
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
        
        answerTableView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 40).isActive = true
        answerTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        answerTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        answerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        
    }
    
}

//// =======================/ EXTENSIONS \===========================

extension FinalViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = headerView(frame: CGRect(x: 10, y: 10, width: answerTableView.frame.size.width - 20, height: 40))
        headerview.delegate = self
        headerview.secIndex = section
        headerview.headerButton.setTitle(Data[section].headerName, for: .normal)
        headerview.countLabel.text = "\(section+1)"
        
        if(Data[section].subtype != ["Correct"]){
            headerview.countLabel.textColor = customColor.singleton.crossColor
            headerview.headerButton.setTitleColor(customColor.singleton.crossColor, for: .normal)
            headerview.image.image = UIImage(named: "wrong_big.png")
        }
        
        return headerview
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Data[section].isExpandable{
            return Data[section].subtype.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Data[indexPath.section].isExpandable{
            return 30
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        cell?.contentView.addSubview(self.cellView)
        cell?.backgroundColor = .clear
        
        self.correctAnswerLabel.text = Data[indexPath.section].subtype[indexPath.row]
        
        cellView.topAnchor.constraint(equalTo: (cell?.contentView.topAnchor)!).isActive = true
        cellView.bottomAnchor.constraint(equalTo: (cell?.contentView.bottomAnchor)!).isActive = true
        cellView.leftAnchor.constraint(equalTo: (cell?.contentView.leftAnchor)!, constant: 10).isActive = true
        cellView.rightAnchor.constraint(equalTo: (cell?.contentView.rightAnchor)!, constant: -10).isActive = true
        
        cellView.addSubview(self.correctAnswerLabel)
        correctAnswerLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        correctAnswerLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        cell?.clipsToBounds = true
        return cell!
        
    }
    
}

extension FinalViewController: HeaderDelegate{
    func callHeader(idx: Int) {
        Data[idx].isExpandable = !Data[idx].isExpandable
        answerTableView.reloadSections([idx], with: .none)
    }
    
}


