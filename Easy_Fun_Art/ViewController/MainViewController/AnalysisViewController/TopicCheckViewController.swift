//
//  TopicCheckViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class TopicCheckViewController: UIViewController {

    @IBOutlet weak var topicCollectionView: UICollectionView!
    @IBOutlet weak var topicCollectionViewHeight: NSLayoutConstraint!
    
    var topic = ["1":["title":"모험", "isOn":0],
                 "2":["title":"코믹", "isOn":0],
                 "3":["title":"범죄", "isOn":0],
                 "4":["title":"판타지", "isOn":0],
                 "5":["title":"픽션", "isOn":0],
                 "6":["title":"공포/스릴러", "isOn":0],
                 "7":["title":"미스터리", "isOn":0],
                 "8":["title":"철학", "isOn":0],
                 "9":["title":"정치", "isOn":0],
                 "10":["title":"사랑", "isOn":0],
                 "11":["title":"풍자", "isOn":0],
                 "12":["title":"과학", "isOn":0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicCollectionView.delegate = self; topicCollectionView.dataSource = self
        topicCollectionViewHeight.constant = 6*150.0*self.view.frame.height/667 + 5*10.0
    }
    
    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let analysisEndViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AnalysisEndViewController.reuseIdentifier) as! AnalysisEndViewController
        
        self.navigationController?.pushViewController(analysisEndViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TopicCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCheckCollectionViewCell.reuseIdentifier, for: indexPath) as! TopicCheckCollectionViewCell
        cell.topicToggleButton.setImage(UIImage(named: "btn_topic\(indexPath.row+1)_off"), for: .normal)
        cell.topicToggleButton.falseImage = UIImage(named: "btn_topic\(indexPath.row+1)_off")
        cell.topicToggleButton.trueImage = UIImage(named: "btn_topic\(indexPath.row+1)_on")
        return cell
    }
}

extension TopicCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0*self.view.frame.width/375, height: 150.0*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30.0*self.view.frame.width/375, bottom: 0, right: 30.0*self.view.frame.width/375)
    }
    
}
