//
//  ExhibitionInfoHeaderViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 5..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class ExhibitionInfoHeaderViewController: UIViewController {

    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var shareButtonImageView: UIImageView!
    @IBOutlet weak var exhibitionImageView: UIImageView!
    @IBOutlet weak var exhibitionTitleLabel: UILabel!
    @IBOutlet weak var exhibitionDateLabel: UILabel!
    @IBOutlet weak var galleryLabel: UILabel!
    @IBOutlet weak var myRatingLabel: UILabel!
    @IBOutlet weak var ratingScoreLabel: UILabel!
    
    var exhibitionData: ExhibitionDetail.ExhibitionDetailData?
    var exhibitionTitle: String?
    var date: String?
    var gallery: String?
    var image: UIImage?
    var exhibitionId = -1
    var likeFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(imageAlphaChange(_:)), name: NSNotification.Name("detailMainScroll"), object: nil)
        
        exhibitionTitleLabel.text = exhibitionTitle
        exhibitionDateLabel.text = date
        galleryLabel.text = gallery
        exhibitionImageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loading(.start)
        exhibitionDetailUpdate()
    }
    
    @IBAction func pressedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressedLikeIt(_ sender: Any) {
        likeButtonImageView.viewAnimation()
        
        HomeService.shareInstance.likeExhibition(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let likeFlag):
                if likeFlag == 1 {
                    self.likeButtonImageView.image = #imageLiteral(resourceName: "btn_like_red")
                    let likeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LikeViewController.reuseIdentifier) as! LikeViewController
                    self.present(likeViewController, animated: true, completion: nil)
                } else {
                    self.likeButtonImageView.image = #imageLiteral(resourceName: "btn_like_white")
                }
                
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
    @IBAction func pressedShareIt(_ sender: Any) {
        
    }
    
    @objc func imageAlphaChange(_ notification: Notification) {
        guard let scrollOffSet = notification.userInfo?["scroll"] as? CGFloat else { return }
        
        backButtonImageView.alpha = (30-scrollOffSet)/30
        likeButtonImageView.alpha = (30-scrollOffSet)/30
        shareButtonImageView.alpha = (30-scrollOffSet)/30
    }
    
    func firstSetting() {
        myRatingLabel.text = String(format: "%.01f", gfno(exhibitionData?.userInfo.grade))
        ratingScoreLabel.text = String(format: "%.01f", gfno(exhibitionData?.exhibition.average_grade))
        print(likeFlag)
        if gino(exhibitionData?.userInfo.likeFlag) == 1 {
            likeButtonImageView.image = #imageLiteral(resourceName: "btn_like_red")
        } else {
            likeButtonImageView.image = #imageLiteral(resourceName: "btn_like_white")
        }
    }
    
    func exhibitionDetailUpdate() {
        HomeService.shareInstance.exhibitionDetail(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let exhibitionInfo):
                self.loading(.end)
                self.exhibitionData = exhibitionInfo
                self.firstSetting()
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
}
