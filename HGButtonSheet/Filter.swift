//
//  Filter.swift
//  HGButtonSheet
//
//  Created by hesham ghalaab on 5/27/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import Foundation

enum Filter: String {
    case all = "ALL"
    case canceled = "CANCELED"
    case delivered = "DELIVERED"
    case ordered = "PENDING"
    case processing = "IN_PROGRESS"
    case shipped = "SHIPPED"
    case none
    
    init (row: Int){
        switch row {
        case 0: self = .all
        case 1: self = .canceled
        case 2: self = .delivered
        case 3: self = .ordered
        case 4: self = .processing
        case 5: self = .shipped
        default: self = .none
        }
    }
    
    static var values: [String]{
        return ["All", "Canceled", "Delivered", "Ordered", "Processing", "Shipped"]
    }
    
    static var title: String{
        return "Filter"
    }
}
