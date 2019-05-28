//
//  UINavigationController+Extension.swift
//  HGPopUp
//
//  Created by hesham ghalaab on 5/25/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topViewController = presentedViewController{
            return topViewController.preferredStatusBarStyle
        }
        if let topViewController = viewControllers.last {
            return topViewController.preferredStatusBarStyle
        }
        
        return .default
    }
}
