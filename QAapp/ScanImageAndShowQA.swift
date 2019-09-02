//
//  ScanImageAndShowQA.swift
//  QAapp
//
//  Created by Apple on 30/08/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit

class ScanImageAndShowQA: UIViewController {

    
    private let cellId = "cellId"
    
    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "background.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.text = "Questions & Answers"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var questionAnswerTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(QACell.self, forCellReuseIdentifier: cellId)
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
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(customColor.singleton.orangeColor, for: .normal)
        button.backgroundColor = .white //customColor.singleton.greenColor
        button.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    var questions = [String]()
    var answers = [String]()
    
    var titleQuestion = String()
    var titleAnswer = String()
    
    
//    var questionAnswerMergeArray = ["Sicily", "Island ", "Alps", "Mountain Range", "Po", "River", "Vesuvius", "Volcano", "Sardinia", "Island", "Etna", "Volcano", "Gulf of Venice", "Gulf (body of water)", "Rome", "Capital City", "Gulf of Taranto", "Gulf (body of water)", "Tiber", "River", "Apennines ", "Mountain Range"]
    
    
    //    var Data = data.singleton.tableData
    
    
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
        questionAnswerTableView.estimatedRowHeight = 60
        questionAnswerTableView.rowHeight = UITableView.automaticDimension
        
        print("data reloading")
        DispatchQueue.main.async {
            self.questionAnswerTableView.reloadData()

            print("\(data.singleton.questionAnswerMergeArray)")
        }
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var quest = data.singleton.apiResponseQuestion
        var ans = data.singleton.apiResponseAnswer
        
        titleQuestion = quest.remove(at: 0)
        titleAnswer = ans.remove(at: 0)

        self.questions = quest
        self.answers = ans

        self.mergeQuestionAnswers(arr1: self.questions, arr2: self.answers)
        
        self.setupView()
    }
    
    func setupView(){
        
        view.addSubview(backgroundImage)
        view.addSubview(answerLabel)
        view.addSubview(questionAnswerTableView)
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        

        answerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

        questionAnswerTableView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20).isActive = true
        questionAnswerTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        questionAnswerTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        questionAnswerTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
        
        view.addSubview(doneButton)
//        doneButton.topAnchor.constraint(equalTo: questionAnswerTableView.bottomAnchor, constant: 5).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalTo: questionAnswerTableView.widthAnchor, multiplier: 1).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: questionAnswerTableView.centerXAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        
        
    }
    
    
    fileprivate func mergeQuestionAnswers(arr1: [String], arr2: [String]) {
        
        if arr1.count == arr2.count{
            for index in 0..<arr1.count{
                
                data.singleton.questionAnswerMergeArray.append("Q: \(arr1[index])")
                data.singleton.questionAnswerMergeArray.append("A: \(arr2[index])")
            }
        }else{
            print("array length issue")
        }
        
        print(data.singleton.questionAnswerMergeArray)
        
    }
    
    fileprivate func separateQuestionAnswers(mergeArray: [String]) {
        
        data.singleton.apiResponseQuestion.removeAll()
        data.singleton.apiResponseAnswer.removeAll()
        
        for i in 0..<mergeArray.count{
            if(i%2 == 0){
                data.singleton.apiResponseQuestion.append(String(mergeArray[i].dropFirst(3)))
            }else{
                data.singleton.apiResponseAnswer.append(String(mergeArray[i].dropFirst(3)))
            }
        }
        
        data.singleton.apiResponseQuestion.insert(self.titleQuestion, at: 0)
        data.singleton.apiResponseAnswer.insert(self.titleAnswer, at: 0)
        
    }
    
    
    //// OBJECTIVE C FUNCTIONS
    
    @objc func doneButtonHandler(){

        print("done Pressed")
        self.separateQuestionAnswers(mergeArray: data.singleton.questionAnswerMergeArray)
        
        print("PRINTING API RESPONSES CHANGED")
        
        print(data.singleton.apiResponseQuestion)
        print(data.singleton.apiResponseAnswer)
        
        self.show(QAscreen(), sender: self)

    }
    
}

//// =======================/ EXTENSIONS \===========================

extension ScanImageAndShowQA: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.singleton.questionAnswerMergeArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? QACell
        
        cell!.dataTextLabel.text = data.singleton.questionAnswerMergeArray[indexPath.row]
        cell?.dataTextLabel.numberOfLines = 0
        cell?.dataTextLabel.lineBreakMode = .byWordWrapping
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let controller = EditingViewController()
        
        let text = data.singleton.questionAnswerMergeArray[indexPath.row]
        controller.text = String(text.dropFirst(3))
        controller.index = indexPath.row
        
        DispatchQueue.main.async{
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}

class QACell: UITableViewCell {

    
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
//        dataTextLabel.backgroundColor = .blue
        dataTextLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        dataTextLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
        dataTextLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        dataTextLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


