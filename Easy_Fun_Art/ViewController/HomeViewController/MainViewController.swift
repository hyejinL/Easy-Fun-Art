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
    @IBOutlet weak var docentSearchTextField: UITextField!
    
    var homeTopData: [HomeExhibition]?
    var homeBottomData: Home.HomeData.HomeBottomData?
    var homeBottomTheme: [HomeExhibition]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        topRecommendCollectionView.delegate = self; topRecommendCollectionView.dataSource = self
        bottomRecommendCollectionView.delegate = self; bottomRecommendCollectionView.dataSource = self
        
        docentSearchTextField.attributedPlaceholder = NSAttributedString(string: "도슨트를 위한 일련번호를 입력해주세요", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainNetworking()
        loading(.start)
    }
    
    override func viewDidLayoutSubviews() {
        bottomRecommendCollectionViewHeight.constant = bottomRecommendCollectionView.contentSize.height+100
    }
    
    func mainNetworking() {
        HomeService.shareInstance.mainInfo { (result) in
            switch result {
            case .success(let homeData):
                self.homeTopData = homeData.topData
                self.homeBottomData = homeData.bottomResult
                
                self.topRecommendCollectionView.reloadData()
                self.bottomRecommendCollectionView.reloadData()
                
                self.loading(.end)

                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
    @objc func goDocentPopUp() {
        let mainPopUpViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: MainPopUpViewController.reuseIdentifier) as! MainPopUpViewController
        self.present(mainPopUpViewController, animated: true, completion: nil)
    }
    
    @objc func goExhibitionDetailView() {
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        self.navigationController?.pushViewController(exhibitionInfoViewController, animated: true)
    }
    
    @objc func pressedLikeIt() {
        let likeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LikeViewController.reuseIdentifier) as! LikeViewController
        self.present(likeViewController, animated: true, completion: nil)
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
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainRecoHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoHeaderCollectionViewCell
        
        if indexPath.section == 0 {
            view.mainHeaderTitleLabel.text = homeBottomData?.theme1[0].theme_title
        } else if indexPath.section == 1 {
            view.mainHeaderTitleLabel.text = homeBottomData?.theme2[0].theme_title
        } else {
            view.mainHeaderTitleLabel.text = homeBottomData?.theme3[0].theme_title
        }
        
        
        return view
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topRecommendCollectionView {
            return gino(homeTopData?.count)
        } else {
            if section == 0 {
                return gino(homeBottomData?.theme1.count)
            } else if section == 1 {
                return gino(homeBottomData?.theme2.count)
            } else {
                return gino(homeBottomData?.theme3.count)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topRecommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTopRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainTopRecoCollectionViewCell
            
            cell.exhibitionImageView.layer.cornerRadius = 5.0
            cell.exhibitionImageView.layer.masksToBounds = true
            
            cell.exhibitionId = gino(homeTopData?[indexPath.row].ex_id)
            cell.exhibitionImageView.image = UIImage(named: gsno(homeTopData?[indexPath.row].ex_image))
            cell.exhibitionTitleLabel.text = homeTopData?[indexPath.row].ex_title

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
            
            cell.goDocentButton.addTarget(self, action: #selector(goDocentPopUp), for: .touchUpInside)
            cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailView), for: .touchUpInside)
            cell.likeButton.addTarget(self, action: #selector(pressedLikeIt), for: .touchUpInside)
            
            
            if indexPath.section == 0 {
                homeBottomTheme = homeBottomData?.theme1
            } else if indexPath.section == 1 {
                homeBottomTheme = homeBottomData?.theme2
            } else {
                homeBottomTheme = homeBottomData?.theme3
            }
            
            cell.exhibitionId = gino(homeBottomTheme?[indexPath.row].ex_id)
            cell.exhibitionRatingView.rating = Double(gfno(homeBottomTheme?[indexPath.row].ex_average_grade))
            cell.exhibitionRatingLabel.text = String(format: "%.01f", gfno(homeBottomTheme?[indexPath.row].ex_average_grade))
            cell.exhibitionTitleLabel.text = homeBottomTheme?[indexPath.row].ex_title
            cell.exhibitionDateLabel.text = "\(gsno(homeBottomTheme?[indexPath.row].ex_start_date)) ~ \(gsno(homeBottomTheme?[indexPath.row].ex_end_date))"
            cell.galleryId = gino(homeBottomTheme?[indexPath.row].gallery_id)
            cell.exhibitionLocationLabel.text = homeBottomTheme?[indexPath.row].gallery_name

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

