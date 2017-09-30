//
//  SmartTextField.swift
//  OnTheMap
//
//  Created by Martin Janák on 30/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class SmartTextField: BaseTextField, UITextFieldDelegate {
    
    var contentView: UIView?
    
    var keyboardHeight: CGFloat = 0
    
    var onTextChange: (() -> Void)?
    var validator: ((String?) -> Bool)?
    
    override func setup() {
        delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if keyboardHeight > 0 {
            moveFrameIfNeeded(keyboardHeight)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as String
        
        text = newText
        
        if let onTextChange = onTextChange {
            DispatchQueue.main.async {
                onTextChange()
            }
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func subscribeKeyboardListener(contentView: UIView) {
        
        self.contentView = contentView
        
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeKeyboardListener() {
        NotificationCenter
            .default
            .removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter
            .default
            .removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        keyboardHeight = getKeyboardHeight(notification)
        if isEditing {
            moveFrameIfNeeded(keyboardHeight)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        if let contentView = contentView,
            contentView.frame.origin.y != 0 {
            contentView.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func moveFrameIfNeeded(_ keyboardHeight: CGFloat) {
        
        if let contentView = contentView {
            let freeHeight = contentView.frame.height - keyboardHeight
            let fieldBottomY = frame.origin.y + frame.height
            
            let space = freeHeight - fieldBottomY - 5
            
            if space < 0.0 {
                contentView.frame.origin.y = space
            }
        }
    }
    
    func isValid() -> Bool {
        if let validator = validator {
            return validator(text)
        } else {
            return true
        }
    }
    
}
