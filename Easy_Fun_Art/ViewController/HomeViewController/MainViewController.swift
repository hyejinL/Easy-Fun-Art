//
//  MainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 4..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var topRecommendCollectionView: UICollectionView!
    @IBOutlet weak var bottomRecommendCollectionView: UICollectionView!
    @IBOutlet weak var bottomRecommendCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var docentSearchTextField: UITextField!
    @IBOutlet weak var scrollBiggerImageView: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var biggerImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var biggerImageViewHeight: NSLayoutConstraint!
    
    var homeTopData: [HomeExhibition]?
    var homeBottomData: Home.HomeData.HomeBottomData?
    var homeBottomTheme: [HomeExhibition]?
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRecommendCollectionView.delegate = self; topRecommendCollectionView.dataSource = self
        bottomRecommendCollectionView.delegate = self; bottomRecommendCollectionView.dataSource = self
        
        docentSearchTextField.attributedPlaceholder = NSAttributedString(string: "도슨트를 위한 일련번호를 입력해주세요", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        docentSearchTextField.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        setUpCollectionView()
        
        textFieldFirstSetting()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pressedLikeIt), name: NSNotification.Name("likeExhibition"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        mainNetworking()
        loading(.start)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomRecommendCollectionViewHeight.constant = bottomRecommendCollectionView.contentSize.height+100
        
        let imageHeight = scrollBiggerImageView.frame.height

//        let newOrigin = CGPoint(x: 0, y: -imageHeight)
//
//        mainScrollView.contentOffset = newOrigin
//        mainScrollView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = mainScrollView.contentOffset.y
        
        if offsetY < 0 {
            biggerImageViewTop.constant = offsetY
            biggerImageViewHeight.constant = -offsetY+390*self.view.frame.height/667
        } else {
            scrollBiggerImageView.frame.size.height = scrollBiggerImageView.frame.height
        }
        
        self.view.layoutIfNeeded()
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
    
    @objc func goDocentPopUp(_ button: UIButton) {
        let mainPopUpViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: MainPopUpViewController.reuseIdentifier) as! MainPopUpViewController
        guard let cell = button.superview?.superview?.superview as? MainRecoCollectionViewCell else { return }
        
        mainPopUpViewController.exhibitionID = cell.exhibitionId
        mainPopUpViewController.exhibitionText = cell.exhibitionTitleLabel.text
        mainPopUpViewController.exhibitonImage = cell.exhibitionImageView.image
        mainPopUpViewController.galleryText = cell.exhibitionLocationLabel.text
        
        self.tabBarController?.present(mainPopUpViewController, animated: true, completion: nil)
    }
    
    @objc func goExhibitionDetailViewAtCellButton(_ button: UIButton) {
        guard let cell = button.superview?.superview as? MainRecoCollectionViewCell else { return }
        
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        
        exhibitionInfoViewController.id = cell.exhibitionId
        exhibitionInfoViewController.exhibitionTitle = cell.exhibitionTitleLabel.text
        exhibitionInfoViewController.date = cell.exhibitionDateLabel.text
        exhibitionInfoViewController.gallery = cell.exhibitionLocationLabel.text
        exhibitionInfoViewController.image = cell.exhibitionImageView.image
        exhibitionInfoViewController.galleryId = cell.galleryId
        
        self.navigationController?.pushViewController(exhibitionInfoViewController, animated: true)
    }
    
    @objc func goExhibitionDetailViewAtCell(_ id: Int) {
        print(22222)
        let exhibitionInfoViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: ExhibitionInfoViewController.reuseIdentifier) as! ExhibitionInfoViewController
        print(id)
        exhibitionInfoViewController.id = id
        self.navigationController?.pushViewController(exhibitionInfoViewController, animated: true)
    }
    
    @objc func pressedLikeIt(_ notification: Notification) {
//        guard let cellId = notification.userInfo?["cellId"] as? Int,
//            let theme = notification.userInfo?["theme"] as? [HomeExhibition],
//            let like = notification.userInfo?["likeFlag"] as? Int else { return }
//        let theme2 = notification.userInfo?["theme"] as? [HomeExhibition]
//
//        for element in theme {
//            if element.ex_id == cellId {
//                if homeBottomTheme == theme2 {
////                    homeBottomTheme?[cellId].likeFlag = notification.userInfo?["likeFlag"] as? Int
//                }
//            }
//        }
        
        guard let like = notification.userInfo?["like"] as? Int else { return }
        
        if like == 1 {
            let likeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LikeViewController.reuseIdentifier) as! LikeViewController
            let exhibitionText = notification.userInfo?["exhibitionText"] as? String
            
            likeViewController.exhibitionText = exhibitionText
            self.present(likeViewController, animated: true, completion: nil)
        }
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
            cell.exhibitionImageView.imageFromUrl(gsno(homeTopData?[indexPath.row].ex_image), defaultImgPath: "1")
                
            cell.exhibitionTitleLabel.text = homeTopData?[indexPath.row].ex_title

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
            
            cell.goDocentButton.addTarget(self, action: #selector(goDocentPopUp), for: .touchUpInside)
            cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailViewAtCellButton(_:)), for: .touchUpInside)
            
            
            if indexPath.section == 0 {
                homeBottomTheme = homeBottomData?.theme1
            } else if indexPath.section == 1 {
                homeBottomTheme = homeBottomData?.theme2
            } else {
                homeBottomTheme = homeBottomData?.theme3
            }
            
            cell.exhibitionTheme = homeBottomTheme
            cell.exhibitionId = gino(homeBottomTheme?[indexPath.row].ex_id)
            cell.exhibitionRatingView.rating = Double(gfno(homeBottomTheme?[indexPath.row].ex_average_grade))
            cell.exhibitionRatingLabel.text = String(format: "%.01f", gfno(homeBottomTheme?[indexPath.row].ex_average_grade))
            cell.exhibitionTitleLabel.text = homeBottomTheme?[indexPath.row].ex_title
            cell.exhibitionDateLabel.text = "\(gsno(homeBottomTheme?[indexPath.row].ex_start_date)) ~ \(gsno(homeBottomTheme?[indexPath.row].ex_end_date))"
            cell.galleryId = gino(homeBottomTheme?[indexPath.row].gallery_id)
            cell.exhibitionLocationLabel.text = homeBottomTheme?[indexPath.row].gallery_name
            cell.ratingViewWidth.constant = CGFloat(gfno(homeBottomTheme?[indexPath.row].ex_average_grade)/5)*55
            
            if gino(homeBottomTheme?[indexPath.row].likeFlag) == 1 {
                cell.likeButton.isChecked = true
            } else {
                cell.likeButton.isChecked = false
            }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topRecommendCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTopRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainTopRecoCollectionViewCell
            goExhibitionDetailViewAtCell(cell.exhibitionId)
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

// 텍스트 필드 조정
extension MainViewController : UITextFieldDelegate {
    func textFieldFirstSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Save Data after Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.docentSearchTextField.resignFirstResponder()
        return false
    }
    
    @objc func tapBackground(_ sender: UITapGestureRecognizer?) {
        self.docentSearchTextField.resignFirstResponder()
    }
    
    func adjustKeyboardDismisTapGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismisTapGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismisTapGesture(isKeyboardVisible: false)
    }
    
}

