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
    
    let userdefault = UserDefaults.standard
    
    var genre = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genreCollectionView.delegate = self; genreCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        genreCollectionViewHeight.constant = genreCollectionView.contentSize.height
    }

    @IBAction func pressedAnalysisNextButton(_ sender: Any) {
        let placeCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PlaceCheckViewController.reuseIdentifier) as! PlaceCheckViewController
        
        var genreText = ""
        
        for (i, element) in genre.enumerated() {
            genreText += "\(element)"
            if i < genre.count-1 {
                genreText += ","
            }
        }
        
        placeCheckViewController.genre = genreText
        print(genreText)
        
        self.navigationController?.pushViewController(placeCheckViewController, animated: true)
    }
    
    @IBAction func pressedAnalysisBeforeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func choosePreference(_ button: ToggleButton) {
        button.buttonAnimation()
        
        guard let cell = button.superview?.superview as? GenreCheckCollectionViewCell else { return }
        
        if button.isChecked {
            genre[cell.id] = 1
        } else {
            genre[cell.id] = 0
        }
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
        cell.genreToggleButton.addTarget(self, action: #selector(choosePreference(_:)), for: .touchUpInside)
        cell.id = indexPath.row
        
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
