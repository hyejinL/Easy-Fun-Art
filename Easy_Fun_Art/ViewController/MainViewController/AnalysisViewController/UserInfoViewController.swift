//
//  UserInfoViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userNicknameTextField: UITextField!
    @IBOutlet weak var nicknameErrMsgLabel: UILabel!
    @IBOutlet weak var femaleButton: ToggleButton!
    @IBOutlet weak var maleButton: ToggleButton!
    @IBOutlet weak var age10sButton: ToggleButton!
    @IBOutlet weak var age20sButton: ToggleButton!
    @IBOutlet weak var age30sButton: ToggleButton!
    @IBOutlet weak var age40sButton: ToggleButton!
    @IBOutlet weak var age50sButton: ToggleButton!
    @IBOutlet weak var age60sButton: ToggleButton!
    
    var check = true
    var genderButton = [ToggleButton]()
    var ageButton = [ToggleButton]()
    var gender = -1
    var age = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonFirstSetting()

        userNicknameTextField.delegate = self
        textFieldFirstSetting()
        
        nicknameErrMsgLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        if let nicknameBlankCheck = userNicknameTextField.text?.contains(" ") {
            if nicknameBlankCheck {
                nicknameErrMsgLabel.text = "닉네임은 공백이 없게 해주세요 :("
                nicknameErrMsgHidden()
            } else {
                for button in self.genderButton {
                    if button.isChecked {
                        guard let checkButton = Int(button.title) else { return }
                        gender = checkButton
                    }
                }
                for button in self.ageButton {
                    if button.isChecked {
                        guard let checkButton = Int(button.title) else { return }
                        age = checkButton
                    }
                }
                
                if nicknameErrMsgLabel.text == "" || gender == -1 || age == -1 {
                    self.simpleAlert(title: "모든 항목을 채워주세요", msg: "")
                } else {
                    nicknameCheck()
                    loading(.start)
                }
            }
        }
    }
    
    @IBAction func pressedCheckGenderButton(_ sender: ToggleButton) {
        if sender == femaleButton && femaleButton.isChecked {
            maleButton.isChecked = false
        }
        if sender == maleButton && maleButton.isChecked {
            femaleButton.isChecked = false
        }
    }
    
    @IBAction func pressedCheckAgeButton(_ sender: ToggleButton) {
        if sender.isChecked {
            for button in ageButton {
                if sender != button {
                    button.isChecked = false
                }
            }
        }
    }
    
    func buttonFirstSetting() {
        genderButton = [femaleButton, maleButton]
        ageButton = [age10sButton, age20sButton, age30sButton, age40sButton, age50sButton, age60sButton]
        
        femaleButton.title = "1"
        maleButton.title = "0"
        
        age10sButton.title = "10"
        age20sButton.title = "20"
        age30sButton.title = "30"
        age40sButton.title = "40"
        age50sButton.title = "50"
        age60sButton.title = "60"
    }
    
    func nicknameErrMsgHidden() {
        nicknameErrMsgLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.9) {
            self.nicknameErrMsgLabel.isHidden = true
        }
    }
    
    func nicknameCheck() {
        UserService.sharedInstance.userNicknameCheck(nickname: gsno(userNicknameTextField.text)) { (result) in
            switch result {
            case .success(let check):
                if check == 0 {
                    self.nicknameErrMsgLabel.text = "이미 존재하는 닉네임입니다 :("
                    self.nicknameErrMsgHidden()
                    self.loading(.end)
                } else {
                    self.sendUserInfo()
                }
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
    func sendUserInfo() {
        print(gender, age)
        UserService.sharedInstance.sendUserInfo(nickname: gsno(userNicknameTextField.text), gender: gender, age: age) { (result) in
            switch result {
            case .success():
                let genreCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GenreCheckViewController.reuseIdentifier) as! GenreCheckViewController
                
                self.navigationController?.pushViewController(genreCheckViewController, animated: true)
                self.loading(.end)
                break
            case  .error(let msg):
                print(msg)
                break
            }
        }
    }
}

// 텍스트 필드 조정
extension UserInfoViewController : UITextFieldDelegate {
    
    func textFieldFirstSetting() {
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    // MARK: Save Data after Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userNicknameTextField.resignFirstResponder()
        return false
    }
    
    @objc func tapBackground(_ sender: UITapGestureRecognizer?) {
        self.userNicknameTextField.resignFirstResponder()
    }
    
    // MARK: View Height with Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboard_height = keyboardSize.height
                let centerY = (self.view.frame.height - keyboard_height)/2
                self.view.center.y = centerY
                view.layoutIfNeeded()
                //                check = false
            }//if let keyboardSize
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            view.layoutIfNeeded()
            //            check = true
        }
    }
    
}
