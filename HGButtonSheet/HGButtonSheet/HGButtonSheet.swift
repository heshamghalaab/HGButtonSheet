//
//  HGButtonSheet.swift
//  HGButtonSheet
//
//  Created by hesham ghalaab on 5/15/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

class HGButtonSheet: UIView {

    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var placeHolderLabel: UILabel!
    @IBOutlet weak private var warningLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    @IBOutlet weak private var arrowImageView: UIImageView!
    
    @IBOutlet weak private var topOfTextField: NSLayoutConstraint!
    @IBOutlet weak private var topOfPlaceHolderLabel: NSLayoutConstraint!
    @IBOutlet weak private var leadingOfPlaceHolderLabel: NSLayoutConstraint!
    @IBOutlet weak private var warningHeight: NSLayoutConstraint!
    
    /// the padding between the text field and the placeHolder Label.
    private let padding: CGFloat = 2
    
    weak private var vc: UIViewController?
    private var isFirstTimeLayOutSuperView = true
    private var isFirstTimeAnimatePlaceHolder = true
    
    private var fieldPackage = HGBS_FieldPackage()
    private var placeHolderPackage = HGBS_PlaceHolderPackage()
    private var separatorPackage = HGBS_SeparatorPackage()
    private var warningPackage = HGBS_WarningPackage()
    
    var values = [String]()
    var title = String()
    var hasWarning: Bool = false
    var status = HGBS_TextFieldStatus.inActive { didSet { handlingSeparatorView() } }
    private var isMandatory = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        loadNib()
        textField.delegate = self
        self.isHidden = true
    }
    
    private func loadNib(){
        Bundle.main.loadNibNamed("HGButtonSheet", owner: self, options: nil)
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    func setup(withVC vc: UIViewController?, values: [String], title: String, isMandatory: Bool){
        self.vc = vc
        self.isMandatory = isMandatory
        self.values = values
        self.title = title
    }
    
    func setupTextField(with fieldPackage: HGBS_FieldPackage){
        self.fieldPackage = fieldPackage
    }
    
    func setupWarningView(with warningPackage: HGBS_WarningPackage){
        self.warningPackage = warningPackage
    }
    
    func setupPlaceHolderView(with placeHolderPackage: HGBS_PlaceHolderPackage){
        self.placeHolderPackage = placeHolderPackage
    }
    
    func setupSeparator(with separatorPackage: HGBS_SeparatorPackage){
        self.separatorPackage = separatorPackage
    }
    
    func beginHandlingUI(){
        beginHandlingPlaceHolderUI()
        beginHandlingWarningUI()
        beginHandlingTextUI()
        
        setText(with: self.fieldPackage.text)
        setWarningText(with: self.warningPackage.warningText)
        self.isHidden = false
    }
    
    private func beginHandlingPlaceHolderUI(){
        placeHolderLabel.text = placeHolderPackage.text
    }
    
    private func beginHandlingTextUI(){
        textField.font = fieldPackage.textFont
        textField.textColor = fieldPackage.textColor
        textField.tintColor = placeHolderPackage.activeColor
    }
    
    private func beginHandlingWarningUI(){
        warningLabel.font = warningPackage.warningFont
        warningLabel.textColor = warningPackage.warningColor
    }
    
    func setText(with text: String?){
        self.fieldPackage.text = text
        self.handlingSeparatorView()
        
        guard let text = text else {
            self.inActivePlaceHolderAnimation()
            return
        }
        
        self.activePlaceHolderAnimation()
        textField.text = text
    }
    
    func getText() -> String?{
        return self.fieldPackage.text
    }
    
    func setWarningText(with warningText: String?){
        self.warningPackage.warningText = warningText
        
        guard let warningText = warningText else {
            hasWarning = false
            handlingSeparatorView()
            warningHeight.constant = 0
            layOutSuperView()
            return
        }
        
        let width = warningLabel.frame.width
        hasWarning = true
        handlingSeparatorView()
        warningLabel.text = warningText
        warningHeight.constant = height(withWidth: width, font: warningLabel.font)
        layOutSuperView()
    }
    
    private func handleStatus(with newStatus: HGBS_TextFieldStatus){
        self.status = newStatus
    }
    
    private func handlingSeparatorView(){
        guard !hasWarning else{
            self.separatorView.backgroundColor = self.separatorPackage.atWarningColor
            self.arrowImageView.tintColor = self.separatorPackage.atWarningColor
            return
        }
        
        switch self.status {
        case .active:
            self.separatorView.backgroundColor = self.separatorPackage.activeColor
            self.arrowImageView.tintColor = self.separatorPackage.activeColor
        case .inActive:
            self.separatorView.backgroundColor = self.separatorPackage.inActiveColor
            self.arrowImageView.tintColor = self.separatorPackage.inActiveColor
        }
    }
    
    private func activePlaceHolderAnimation(){
        let placeHolderHight = height(withWidth: placeHolderLabel.frame.width, font: placeHolderPackage.font)
        topOfTextField.constant = placeHolderHight + padding
        topOfPlaceHolderLabel.constant = 0
        handleStatus(with: .active)
        
        guard !isFirstTimeAnimatePlaceHolder else {
            self.animatePlaceHolder(with: self.placeHolderPackage.activeColor,
                                    font: placeHolderPackage.font,
                                    transform: CGAffineTransform(scaleX: 1, y: 1), leading: 0)
            self.isFirstTimeAnimatePlaceHolder = false
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.animatePlaceHolder(with: self.placeHolderPackage.activeColor,
                                    font: self.placeHolderPackage.font,
                                    transform: CGAffineTransform(scaleX: 1, y: 1), leading: 0)
        })
    }
    
    private func inActivePlaceHolderAnimation(){
        let textHight = height(withWidth: textField.frame.width, font: fieldPackage.textFont)
        let placeHolderHight = height(withWidth: placeHolderLabel.frame.width, font: placeHolderPackage.font)
        topOfTextField.constant =  padding
        topOfPlaceHolderLabel.constant = (textHight / 2) - (placeHolderHight / 2)
        handleStatus(with: .inActive)
        
        guard !isFirstTimeAnimatePlaceHolder else {
            self.animatePlaceHolder(with: placeHolderPackage.InActiveColor,
                                    font: placeHolderPackage.font,
                                    transform: CGAffineTransform(scaleX: 0.925, y: 0.925),
                                    leading: -14)
            self.isFirstTimeAnimatePlaceHolder = false
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.animatePlaceHolder(with: self.placeHolderPackage.InActiveColor,
                                    font: self.placeHolderPackage.font,
                                    transform: CGAffineTransform(scaleX: 0.925, y: 0.925),
                                    leading: -14)
        })
    }
    
    private func animatePlaceHolder(with color: UIColor, font: UIFont, transform: CGAffineTransform, leading: CGFloat){
        self.placeHolderLabel.textColor = color
        self.placeHolderLabel.font = font
        self.placeHolderLabel.transform = transform
        self.leadingOfPlaceHolderLabel.constant = leading
        self.vc?.view.layoutIfNeeded()
    }
    
    private func layOutSuperView(){
        guard !isFirstTimeLayOutSuperView else {
            self.vc?.view.layoutIfNeeded()
            self.isFirstTimeLayOutSuperView = false
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.vc?.view.layoutIfNeeded()
        })
    }
    
    private func height(withWidth width: CGFloat, font: UIFont, value: String = "Any value") -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = value.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func isValidate() -> Bool{
        guard self.isMandatory else {
            setWarningText(with: nil)
            return true
        }
        
        guard let text = fieldPackage.text, !text.isEmpty else {
            setWarningText(with: "field is required")
            return false
        }
        
        setWarningText(with: nil)
        return true
    }
    
    @IBAction func openActonSheetTapped(_ sender: UIButton) {
        let presenter = HGPopUpPresenter(vc: vc)
        presenter.present(.HGPopUp(withValues: values, AndTitle: title, mainView: self))
    }
    
}

extension HGButtonSheet: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activePlaceHolderAnimation()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let _ = isValidate()
        guard let text = textField.text, !text.isEmpty else {
            inActivePlaceHolderAnimation()
            return
        }
    }
}
