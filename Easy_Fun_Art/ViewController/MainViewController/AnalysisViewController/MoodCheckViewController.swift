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
    
    var mood = ["1":["title":"적막감", "isOn":0],
                 "2":["title":"환상적인", "isOn":0],
                 "3":["title":"세련된", "isOn":0],
                 "4":["title":"편안한", "isOn":0],
                 "5":["title":"강렬한", "isOn":0],
                 "6":["title":"따뜻한", "isOn":0],
                 "7":["title":"슬픈", "isOn":0],
                 "8":["title":"유유자적한", "isOn":0],
                 "9":["title":"우아한", "isOn":0],
                 "10":["title":"시원한", "isOn":0],
                 "11":["title":"사실적인", "isOn":0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moodCollectionView.delegate = self; moodCollectionView.dataSource = self
        moodCollectionViewHeight.constant = 11*85.0*self.view.frame.height/667 + 10*10.0
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let topicCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TopicCheckViewController.reuseIdentifier) as! TopicCheckViewController
        
        self.navigationController?.pushViewController(topicCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
