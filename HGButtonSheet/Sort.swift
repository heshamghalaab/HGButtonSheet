//
//  Sort.swift
//  HGButtonSheet
//
//  Created by hesham ghalaab on 5/27/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import Foundation

enum Sort: String {
    case all = "ALL"
    case dateAdded = "DATE_ADDED"
    case new = "NEW"
    case none
    
    init (row: Int){
        switch row {
        case 0: self = .all
        case 1: self = .dateAdded
        case 2: self = .new
        default: self = .none
        }
    }
    
    static var values: [String]{
        return ["All", "date added", "new"]
    }
    
    static var title: String{
        return "Sort"
    }
}
