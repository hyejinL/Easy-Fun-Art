//
//  MainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var topRecommendCollectionView: UICollectionView!
    @IBOutlet weak var bottomRecommendCollectionView: UICollectionView!
    @IBOutlet weak var bottomRecommendCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        topRecommendCollectionView.delegate = self; topRecommendCollectionView.dataSource = self
        bottomRecommendCollectionView.delegate = self; bottomRecommendCollectionView.dataSource = self
        
        setUpCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        bottomRecommendCollectionViewHeight.constant = bottomRecommendCollectionView.contentSize.height+100
    }
    
    @objc func goDocentPopUp() {
        let mainPopUpViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: MainPopUpViewController.reuseIdentifier) as! MainPopUpViewController
        self.present(mainPopUpViewController, animated: true, completion: nil)
    }
    
    @objc func goExhibitionDetailView() {
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        self.navigationController?.pushViewController(exhibitionInfoViewController, animated: true)
//        self.present(exhibitionInfoViewController, animated: true, completion: nil)
    }
}

extension MainViewController {
    func setUpCollectionView() {
//        bottomRecommendCollectionView.register(UINib(nibName: MainTopRecoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainRecoHeaderCollectionViewCell.reuseIdentifier)
        bottomRecommendCollectionView.register(UINib(nibName: MainRecoHeaderCollectionViewCell.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: MainRecoHeaderCollectionViewCell.reuseIdentifier)
        bottomRecommendCollectionView.register(UINib(nibName: MainRecoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == topRecommendCollectionView {
            return 1
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
//        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainRecoHeaderCollectionViewCell.reuseIdentifier, for: indexPath)
        return view
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topRecommendCollectionView {
            return 11
        } else {
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topRecommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTopRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainTopRecoCollectionViewCell
            cell.exhibitionImageView.layer.cornerRadius = 5.0
            cell.exhibitionImageView.layer.masksToBounds = true

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
            cell.exhibitionRatingView.rating = Double(indexPath.row)+1.7
            cell.goDocentButton.addTarget(self, action: #selector(goDocentPopUp), for: .touchUpInside)
            cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailView), for: .touchUpInside)

            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == topRecommendCollectionView {
            return CGSize.zero
        } else {
            return CGSize(width: self.view.frame.width, height: 86*self.view.frame.height/667)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topRecommendCollectionView {
            return CGSize(width: 130*self.view.frame.width/375, height: 209*self.view.frame.height/667)
        } else {
            return CGSize(width: self.view.frame.width, height: 175*self.view.frame.height/667)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topRecommendCollectionView {
            return 15.0
        } else {
            return 20.0
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topRecommendCollectionView {
            return UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
        } else {
            return UIEdgeInsets.zero
        }
    }
}

