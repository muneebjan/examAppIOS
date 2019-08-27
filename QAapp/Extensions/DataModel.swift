//
//  DataModel.swift
//  QAapp
//
//  Created by Apple on 16/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import Foundation

class dataModel {
    
    var headerName: String?
    var subtype = [String]()
    var isExpandable: Bool = false
    
    var dataModelArray = [dataModel]()
    
    init(headername: String, subType: [String], isexpandable: Bool) {
        self.headerName = headername
        self.subtype = subType
        self.isExpandable = isexpandable
    }
    
}
