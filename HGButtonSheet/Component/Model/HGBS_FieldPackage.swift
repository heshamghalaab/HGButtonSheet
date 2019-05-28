//
//  HGBS_FieldPackage.swift
//  HGTextField
//
//  Created by hesham ghalaab on 5/28/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

struct HGBS_FieldPackage {
    var text: String?
    let textFont: UIFont
    let textColor: UIColor
    
    init() {
        self.text = nil
        self.textFont = UIFont.systemFont(ofSize: 16)
        self.textColor = .darkGray
    }
    
    init(text: String?, textFont: UIFont, textColor: UIColor) {
        self.text = text
        self.textFont = textFont
        self.textColor = textColor
    }
}
