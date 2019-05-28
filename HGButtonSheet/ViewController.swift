//
//  ViewController.swift
//  HGButtonSheet
//
//  Created by hesham ghalaab on 5/27/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var filterButton: HGButtonSheet!
    @IBOutlet weak var sortButton: HGButtonSheet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var filterPlaceHolderPackage = HGBS_PlaceHolderPackage.init()
        filterPlaceHolderPackage.text = "Filter"
        filterButton.setup(withVC: self, values: Filter.values, title: Filter.title, isMandatory: true)
        filterButton.setupTextField(with: HGBS_FieldPackage.init())
        filterButton.setupPlaceHolderView(with: filterPlaceHolderPackage)
        filterButton.setupWarningView(with: HGBS_WarningPackage.init())
        filterButton.setupSeparator(with: HGBS_SeparatorPackage.init())
        filterButton.beginHandlingUI()
        
        var sortPlaceHolderPackage = HGBS_PlaceHolderPackage.init()
        sortPlaceHolderPackage.text = "Sort"
        sortButton.setup(withVC: self, values: Sort.values, title: Sort.title, isMandatory: true)
        sortButton.setupTextField(with: HGBS_FieldPackage.init())
        sortButton.setupPlaceHolderView(with: sortPlaceHolderPackage)
        sortButton.setupWarningView(with: HGBS_WarningPackage.init())
        sortButton.setupSeparator(with: HGBS_SeparatorPackage.init())
        sortButton.beginHandlingUI()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        let _ = filterButton.isValidate()
        let _ = sortButton.isValidate()
        
        let filter = filterButton.getText()
        let sort = sortButton.getText()
        print("filter is: \(filter ?? "not set yet.").")
        print("sort is: \(sort ?? "not set yet.").")
    }
}

extension ViewController: HGPopUpProtocol{
    func didSelectFromHGPopUp(with row: Int, mainView: HGButtonSheet?) {
        guard let mainView = mainView else {return}
        if mainView == filterButton{
            filterButton.setText(with: Filter.values[row])
            // making sure that the warning text will disaapear if needed.
            let _ = filterButton.isValidate()
            print("filterTextField")
        }else if mainView == sortButton{
            sortButton.setText(with: Sort.values[row]) 
            let _ = sortButton.isValidate()
            print("sortTextField")
        }else{
            print("none")
        }
    }
}

