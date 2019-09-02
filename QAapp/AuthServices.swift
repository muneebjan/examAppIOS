//
//  AuthServices.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class AuthServices {
    

    static let instance = AuthServices()
    
    func updateImageURLtoDatabase(imageURL: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "ImageURL": imageURL
        ]
        
        Alamofire.request(ImageURLapi, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data1 = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data1)
                
                
                let array1 = json["Answers"].arrayObject! as! [String]
                let array2 = json["Questions"].arrayObject! as! [String]
                
                var answerArray = [String]()
                var questionArray = [String]()
                
                for data in array1{
//                    answerArray.append("\(data)")
                    answerArray.append(data.trim())
                }
                for data in array2{
//                    questionArray.append("\(data)")
                    questionArray.append(data.trim())
                }
                
//                let obj = data()
//                obj.apiResponseAnswer = answerArray
//                obj.apiResponseQuestion = questionArray
                
                data.singleton.apiResponseAnswer = answerArray
                data.singleton.apiResponseQuestion = questionArray
                
//                print("Answer API response = \(answerArray)")
//                print("Question API response = \(questionArray)")
                
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
}
