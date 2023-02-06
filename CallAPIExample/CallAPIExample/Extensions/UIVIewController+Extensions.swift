//
//  UIVIewController+Extensions.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/3.
//

import UIKit
extension UIViewController{
    func hidekeyboardWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
}
