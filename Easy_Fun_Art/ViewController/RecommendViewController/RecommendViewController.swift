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
    
    var recommend: [HomeExhibition]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recommendListCollectionView.delegate = self; recommendListCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(pressedLikeIt), name: NSNotification.Name("likeExhibition"), object: nil)
        
        setUpCollectionView()
        recommendUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        loading(.start)
        recommendUpdate()
    }
    
    @objc func goExhibitionDetailView(_ button: UIButton) {
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
    
    func recommendUpdate() {
        RecommendService.shareInstance.RecommendData { (result) in
            switch result {
            case .success(let recommendData):
                self.recommend = recommendData
                self.recommendListCollectionView.reloadData()
                self.loading(.end)
                break
            case .error(let code):
                print(code)
                break
            case .failure(let err):
                self.simpleAlert(title: "네트워크 에러", msg: "인터넷 연결을 확인해주세요.")
                break
            }
        }
    }
    
    
    @objc func pressedLikeIt(_ notification: Notification) {
        guard let like = notification.userInfo?["like"] as? Int else { return }
        
        if like == 1 {
            let likeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LikeViewController.reuseIdentifier) as! LikeViewController
            let exhibitionText = notification.userInfo?["exhibitionText"] as? String
            
            likeViewController.exhibitionText = exhibitionText
            self.present(likeViewController, animated: true, completion: nil)
        }
    }
    
    @objc func goDocentPopUp(_ button: UIButton) {
        let docentPlayListTableViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
        guard let cell = button.superview?.superview?.superview as? MainRecoCollectionViewCell else { return }
        
        docentPlayListTableViewController.exhibitionId = cell.exhibitionId
        docentPlayListTableViewController.exhibitionTitle = cell.exhibitionTitleLabel.text
        docentPlayListTableViewController.exhibitionImage = cell.exhibitionImageURL
        
        self.navigationController?.pushViewController(docentPlayListTableViewController, animated: true)
    }
}

extension RecommendViewController {
    func setUpCollectionView() {
        recommendListCollectionView.register(UINib(nibName: MainRecoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier)
    }
}

extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gino(recommend?.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
        
        cell.goDocentButton.addTarget(self, action: #selector(goDocentPopUp), for: .touchUpInside)
        
        cell.exhibitionId = gino(recommend?[indexPath.row].ex_id)
        cell.exhibitionTitleLabel.text = recommend?[indexPath.row].ex_title
        cell.exhibitionRatingView.rating = Double(gfno(recommend?[indexPath.row].ex_average_grade))
        cell.exhibitionRatingLabel.text = String(format: "%.01f", gfno(recommend?[indexPath.row].ex_average_grade))
        cell.exhibitionDateLabel.text = ""
        cell.galleryId = gino(recommend?[indexPath.row].gallery_id)
        cell.exhibitionLocationLabel.text = recommend?[indexPath.row].gallery_name
        cell.exhibitionImageView.imageFromUrl(gsno(recommend?[indexPath.row].ex_image), defaultImgPath: "1")
        cell.ratingViewWidth.constant = CGFloat(gfno(recommend?[indexPath.row].ex_average_grade)/5)*55
        
        if gino(recommend?[indexPath.row].likeFlag) == 1 {
            cell.likeButton.isChecked = true
        } else {
            cell.likeButton.isChecked = false
        }
        
        cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailView(_:)), for: .touchUpInside)
        
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
