//
//  data.swift
//  QAapp
//
//  Created by Mobeen on 26/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import Foundation

class data {
    
    static let singleton = data()
    
    var correctAnswers = [String]()
    var totalCorrect: Int?
    var wrongAnswers = [String]()
    var questions = [String]()
    var correctIncorrectAnswers = [String]()
    var questionAnswerMergeArray = [String]()
//    var questionAnswerMergeArray = ["Sicily", "Island ", "Alps", "Mountain Range", "Po", "River", "Vesuvius", "Volcano", "Sardinia", "Island", "Etna", "Volcano", "Gulf of Venice", "Gulf (body of water)", "Rome", "Capital City", "Gulf of Taranto", "Gulf (body of water)", "Tiber", "River", "Apennines ", "Mountain Range"]
    
    var apiResponseAnswer = [String]()
    var apiResponseQuestion = [String]()
    
    
    var tableData = [dataModel]()
//    var tableData = [dataModel(headername: "Islamabad", subType: ["Correct"], isexpandable: false),
//                     dataModel(headername: "Lahore", subType: ["incorrect"], isexpandable: false),
//                     dataModel(headername: "Peshawar", subType: ["Correct"], isexpandable: false),
//                     dataModel(headername: "Gujranwala", subType: ["incorrect"], isexpandable: false),
//                     dataModel(headername: "Sheikhupura", subType: ["Correct"], isexpandable: false),
//                     dataModel(headername: "Gujrat", subType: ["Correct"], isexpandable: false)]
    
    
    
}
