//
//  HGBS_SeparatorPackage.swift
//  HGTextField
//
//  Created by hesham ghalaab on 5/28/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

struct HGBS_SeparatorPackage {
    let activeColor: UIColor
    let inActiveColor: UIColor
    let atWarningColor: UIColor
    
    init() {
        self.activeColor = UIColor(red: 10/255, green: 111/255, blue: 127/255, alpha: 1)
        self.inActiveColor = UIColor(red: 154/255, green: 152/255, blue: 153/255, alpha: 1)
        self.atWarningColor = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)
    }
    
    init(activeColor: UIColor, inActiveColor: UIColor, atWarningColor: UIColor) {
        self.activeColor = activeColor
        self.inActiveColor = inActiveColor
        self.atWarningColor = atWarningColor
    }
}
