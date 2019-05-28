//
//  HGBS_PlaceHolderPackage.swift
//  HGTextField
//
//  Created by hesham ghalaab on 5/28/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

struct HGBS_PlaceHolderPackage {
    var text: String
    let font: UIFont
    let activeColor: UIColor
    let InActiveColor: UIColor
    
    init() {
        self.text = "...."
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.activeColor = UIColor(red: 10/255, green: 111/255, blue: 127/255, alpha: 1)
        self.InActiveColor = UIColor(red: 154/255, green: 152/255, blue: 153/255, alpha: 1)
    }
    
    init(text: String, font: UIFont, activeColor: UIColor, InActiveColor: UIColor) {
        self.text = text
        self.font = font
        self.activeColor = activeColor
        self.InActiveColor = InActiveColor
    }
}
