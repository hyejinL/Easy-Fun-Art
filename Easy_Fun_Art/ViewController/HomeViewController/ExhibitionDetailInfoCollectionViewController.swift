//
//  ExhibitionDetailInfoCollectionViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionDetailInfoCollectionViewController: UICollectionViewController {
    
    var exhibitionData: ExhibitionDetail.ExhibitionDetailData?
    var exhibitionId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loading(.start)
        exhibitionDetailUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func exhibitionDetailUpdate() {
        HomeService.shareInstance.exhibitionDetail(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let exhibitionInfo):
                self.exhibitionData = exhibitionInfo
                self.collectionView?.reloadData()
                self.loading(.end)
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
}

extension ExhibitionDetailInfoCollectionViewController {
    func setUpCollectionView() {
        self.collectionView?.register(UINib(nibName: ExhibitionDetailInfoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ExhibitionDetailInfoCollectionViewCell.reuseIdentifier)
        self.collectionView?.register(UINib(nibName: ExhibitionDetailInfo2CollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ExhibitionDetailInfo2CollectionViewCell.reuseIdentifier)
        self.collectionView?.register(UINib(nibName: ExhibitionDetailInfo3CollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ExhibitionDetailInfo3CollectionViewCell.reuseIdentifier)
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}

extension ExhibitionDetailInfoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitionDetailInfoCollectionViewCell.reuseIdentifier, for: indexPath) as! ExhibitionDetailInfoCollectionViewCell
            
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitionDetailInfo2CollectionViewCell.reuseIdentifier, for: indexPath) as! ExhibitionDetailInfo2CollectionViewCell
            cell.exhibitionTextLabel.text = exhibitionData?.exhibition.content
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExhibitionDetailInfo3CollectionViewCell.reuseIdentifier, for: indexPath) as! ExhibitionDetailInfo3CollectionViewCell
            
            cell.configure(authorImage: exhibitionData?.authorResult.author_image, authorText: exhibitionData?.authorResult.author_content)
            
            return cell
        }
    }
}

extension ExhibitionDetailInfoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
