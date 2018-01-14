//
//  ExhibitionDetailInfoCollectionViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionDetailInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cellWidthConst: NSLayoutConstraint!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var hashtagList = [String]()
    var unselectedHashtagList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.cellWidthConst.constant = UIScreen.main.bounds.size.width
        tagCollectionView.collectionViewLayout = LeftAlignedFlowLayout()
    }
    
    func configure() {
        tagCollectionView.delegate = self; tagCollectionView.dataSource = self
        
        if let flowLayout = self.tagCollectionView.collectionViewLayout as? LeftAlignedFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        
        tagCollectionView.register(UINib(nibName: MyHashtagCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MyHashtagCollectionViewCell.reuseIdentifier)
        
        self.tagCollectionView.reloadData()

    }

}

extension ExhibitionDetailInfoCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashtagList.count + unselectedHashtagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHashtagCollectionViewCell.reuseIdentifier, for: indexPath) as! MyHashtagCollectionViewCell
        
        if indexPath.row < hashtagList.count {
            cell.hashtaglabel.text = hashtagList[indexPath.row]
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9926154017, green: 0.8786800504, blue: 0, alpha: 1)
        } else {
            cell.hashtaglabel.text = unselectedHashtagList[indexPath.row - hashtagList.count]
            cell.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
            cell.layer.borderWidth = 0.5
        }
        
        return cell
    }
}

extension ExhibitionReviewTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = self.tagCollectionView.contentSize.width
//        let totalSpacingWidth = CellSpacing * (CellCount - 1)
//
//        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


