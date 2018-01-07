//
//  GenreCheckViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class GenreCheckViewController : UIViewController {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    
    var genre = ["1":["title":"동양화", "isOn":0],
                 "2":["title":"서양화", "isOn":0],
                 "3":["title":"도예", "isOn":0],
                 "4":["title":"금속", "isOn":0],
                 "5":["title":"일러스트", "isOn":0],
                 "6":["title":"목공", "isOn":0],
                 "7":["title":"현대미술", "isOn":0],
                 "8":["title":"팝아트", "isOn":0],
                 "9":["title":"풍경화", "isOn":0],
                 "10":["title":"카툰", "isOn":0],
                 "11":["title":"인물화", "isOn":0],
                 "12":["title":"사진전", "isOn":0]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genreCollectionView.delegate = self; genreCollectionView.dataSource = self
//        print(genre.keys)
        genreCollectionViewHeight.constant = 11*85.0*self.view.frame.height/667 + 10*10.0
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.genreCollectionView.reloadData()
//    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let placeCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PlaceCheckViewController.reuseIdentifier) as! PlaceCheckViewController
        
        self.navigationController?.pushViewController(placeCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GenreCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCheckCollectionViewCell.reuseIdentifier, for: indexPath) as! GenreCheckCollectionViewCell
        
        cell.genreToggleButton.setImage(UIImage(named: "btn_genre\(indexPath.row+1)_off"), for: .normal)
        cell.genreToggleButton.falseImage = UIImage(named: "btn_genre\(indexPath.row+1)_off")
        cell.genreToggleButton.trueImage = UIImage(named: "btn_genre\(indexPath.row+1)_on")
        return cell
    }
}

extension GenreCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 85.0*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
