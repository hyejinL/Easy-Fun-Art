//
//  PlaceCheckViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class PlaceCheckViewController: UIViewController {

    @IBOutlet weak var placeCollectionView: UICollectionView!
    
    var place = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var genre = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeCollectionView.delegate = self; placeCollectionView.dataSource = self
    }
    
    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let moodCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MoodCheckViewController.reuseIdentifier) as! MoodCheckViewController
        
        var placeText = ""
        
        for (i, element) in place.enumerated() {
            placeText += "\(element)"
            if i < place.count-1 {
                placeText += ","
            }
        }
        print(genre)
        
        moodCheckViewController.genre = genre
        moodCheckViewController.place = placeText
        
        self.navigationController?.pushViewController(moodCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func choosePreference(_ button: ToggleButton) {
        button.buttonAnimation()
        
        guard let cell = button.superview?.superview as? PlaceCheckCollectionViewCell else { return }
        
        if button.isChecked {
            place[cell.id] = 1
        } else {
            place[cell.id] = 0
        }
    }
}

extension PlaceCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCheckCollectionViewCell.reuseIdentifier, for: indexPath) as! PlaceCheckCollectionViewCell
        cell.placeToggleButton.setImage(UIImage(named: "btn_place\(indexPath.row+1)_off"), for: .normal)
        cell.placeToggleButton.falseImage = UIImage(named: "btn_place\(indexPath.row+1)_off")
        cell.placeToggleButton.trueImage = UIImage(named: "btn_place\(indexPath.row+1)_on")
        cell.placeToggleButton.addTarget(self, action: #selector(choosePreference(_:)), for: .touchUpInside)
        cell.id = indexPath.row
        cell.layer.cornerRadius = cell.frame.width/2
        
        return cell
    }
}

extension PlaceCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0*self.view.frame.width/375, height: 100.0*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 27.0*self.view.frame.width/375, bottom: 0, right: 27.0*self.view.frame.width/375)
    }
    
}
