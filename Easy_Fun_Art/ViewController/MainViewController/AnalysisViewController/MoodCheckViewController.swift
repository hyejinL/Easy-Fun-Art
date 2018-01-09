//
//  MoodCheckViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MoodCheckViewController: UIViewController {

    @IBOutlet weak var moodCollectionView: UICollectionView!
    @IBOutlet weak var moodCollectionViewHeight: NSLayoutConstraint!
    
    var mood = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var genre = ""
    var place = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moodCollectionView.delegate = self; moodCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        moodCollectionViewHeight.constant = moodCollectionView.contentSize.height
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let topicCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TopicCheckViewController.reuseIdentifier) as! TopicCheckViewController
        
        var moodText = ""
        
        for (i, element) in mood.enumerated() {
            moodText += "\(element)"
            if i < mood.count-1 {
                moodText += ","
            }
        }
        
        topicCheckViewController.genre = genre
        topicCheckViewController.place = place
        topicCheckViewController.mood = moodText
        
        self.navigationController?.pushViewController(topicCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func choosePreference(_ button: ToggleButton) {
        button.buttonAnimation()
        
        guard let cell = button.superview?.superview as? MoodCheckCollectionViewCell else { return }
        
        if button.isChecked {
            mood[cell.id] = 1
        } else {
            mood[cell.id] = 0
        }
    }

}

extension MoodCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodCheckCollectionViewCell.reuseIdentifier, for: indexPath) as! MoodCheckCollectionViewCell
        cell.moodToggleButton.setImage(UIImage(named: "btn_mood\(indexPath.row+1)_off"), for: .normal)
        cell.moodToggleButton.falseImage = UIImage(named: "btn_mood\(indexPath.row+1)_off")
        cell.moodToggleButton.trueImage = UIImage(named: "btn_mood\(indexPath.row+1)_on")
        cell.moodToggleButton.addTarget(self, action: #selector(choosePreference(_:)), for: .touchUpInside)
        cell.id = indexPath.row
        
        return cell
    }
}

extension MoodCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 85.0*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
