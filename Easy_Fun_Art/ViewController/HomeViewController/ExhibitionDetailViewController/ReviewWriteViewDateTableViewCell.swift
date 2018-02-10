//
//  ReviewWriteViewDateTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 2. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ReviewWriteViewDateTableViewCell: UITableViewCell {
    @IBOutlet weak var seeExhibitionDateTextField: UITextField!
    
    let pickerView = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initPickerView() {
        pickerView.datePickerMode = .date
        
//        let barFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        let bar = UIToolbar()
        bar.sizeToFit()
        let btnDone = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(pressedDoneButton))
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        bar.setItems([btnSpace, btnDone], animated: true)
        
        seeExhibitionDateTextField.inputAccessoryView = bar
        seeExhibitionDateTextField.inputView = pickerView
    }
    
    @objc func pressedDoneButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        seeExhibitionDateTextField.text = dateFormatter.string(from: pickerView.date)
        self.endEditing(true)
    }
}
