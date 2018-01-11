//
//  RecommendViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    @IBOutlet weak var recommendListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recommendListCollectionView.delegate = self; recommendListCollectionView.dataSource = self
        
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func goExhibitionDetailView() {
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        self.navigationController?.pushViewController(exhibitionInfoViewController, animated: true)
    }
}

extension RecommendViewController {
    func setUpCollectionView() {
        recommendListCollectionView.register(UINib(nibName: MainRecoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier)
    }
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
        
        cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailView), for: .touchUpInside)
        
        return cell
    }
}

extension RecommendViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 175*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 50.0, right: 0)
    }
}
