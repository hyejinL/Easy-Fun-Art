//
//  ExhibitionDetailInfoViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionDetailInfoViewController: UIViewController {

    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func goStarRatingView(_ sender: Any) {
        let starRatingViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StarRatingViewController.reuseIdentifier) as! StarRatingViewController
        self.present(starRatingViewController, animated: true, completion: nil)
    }
}

extension ExhibitionDetailInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashTagCollectionViewCell", for: indexPath)
        return cell
    }
}

extension ExhibitionDetailInfoViewController: UICollectionViewDelegateFlowLayout {
    
}
