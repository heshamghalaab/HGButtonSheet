//
//  HGBS_WarningPackage.swift
//  HGTextField
//
//  Created by hesham ghalaab on 5/28/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

struct HGBS_WarningPackage {
    var warningText: String?
    let warningFont: UIFont
    let warningColor: UIColor
    
    init() {
        self.warningText = nil
        self.warningFont = UIFont.boldSystemFont(ofSize: 12)
        self.warningColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
    }
    
    init(warningText: String?, warningFont: UIFont, warningColor: UIColor) {
        self.warningText = warningText
        self.warningFont = warningFont
        self.warningColor = warningColor
    }
}
