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
    
    var topic = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var genre = ""
    var place = ""
    var mood = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicCollectionView.delegate = self; topicCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topicCollectionViewHeight.constant = topicCollectionView.contentSize.height
    }
    
    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        loading(.start)
        
        var topicText = ""
        
        for (i, element) in topic.enumerated() {
            topicText += "\(element)"
            if i < topic.count-1 {
                topicText += ","
            }
        }

        endChoosePreference(topic: topicText)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func choosePreference(_ button: ToggleButton) {
        button.buttonAnimation()
        
        guard let cell = button.superview?.superview as? TopicCheckCollectionViewCell else { return }
        
        if button.isChecked {
            topic[cell.id] = 1
        } else {
            topic[cell.id] = 0
        }
    }
    
    func endChoosePreference(topic: String) {
        UserService.sharedInstance.sendUserPreference(preGenre: genre, prePlace: place, preMood: mood, preTopic: topic) { (result) in
            switch result {
            case .success():
                self.loading(.end)
                
                let analysisEndViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AnalysisEndViewController.reuseIdentifier) as! AnalysisEndViewController
                
                self.navigationController?.pushViewController(analysisEndViewController, animated: true)
                
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
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
        cell.topicToggleButton.addTarget(self, action: #selector(choosePreference(_:)), for: .touchUpInside)
        cell.id = indexPath.row
        
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
