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
    
    var place = ["1":["title":"서촌", "isOn":0],
                 "2":["title":"강남", "isOn":0],
                 "3":["title":"홍대/합정", "isOn":0],
                 "4":["title":"인사동", "isOn":0],
                 "5":["title":"이태원", "isOn":0],
                 "6":["title":"충무로", "isOn":0],
                 "7":["title":"혜화/대학로", "isOn":0],
                 "8":["title":"삼청동/북촌", "isOn":0],
                 "9":["title":"기타", "isOn":0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeCollectionView.delegate = self; placeCollectionView.dataSource = self
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let moodCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MoodCheckViewController.reuseIdentifier) as! MoodCheckViewController
        
        self.navigationController?.pushViewController(moodCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
