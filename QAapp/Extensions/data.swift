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
    var correctIncorrectAnswers = [[String]]()
    
    
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
