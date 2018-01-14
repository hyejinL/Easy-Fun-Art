//
//  SearchMainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class SearchMainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.delegate = self
        textFieldFirstSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension SearchMainViewController: UITextFieldDelegate {
    func textFieldFirstSetting() {
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if gino(searchTextField.text?.count) < 2 {
            simpleAlert(title: "검색 오류", msg: "두 글자 이상 입력해주세요 :)")
        } else {
            let searchResultViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: SearchResultViewController.reuseIdentifier) as! SearchResultViewController
            searchResultViewController.searchText = gsno(textField.text)
            self.navigationController?.pushViewController(searchResultViewController, animated: true)
        }
        
        return false
    }
    
    @objc func tapBackground(_ sender: UITapGestureRecognizer?) {
        self.searchTextField.resignFirstResponder()
    }
    
    // MARK: View Height with Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboard_height = keyboardSize.height
                let centerY = (self.view.frame.height - keyboard_height)/2
                self.view.center.y = centerY
                view.layoutIfNeeded()
            }//if let keyboardSize
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            view.layoutIfNeeded()
        }
    }
    
}

