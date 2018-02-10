//
//  ReviewWriteViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 2. 3..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class ReviewWriteViewController: UIViewController {
    @IBOutlet weak var reviewContentTableView: UITableView!
    
    var exhibitionId = -1
    var exhibitionTitle: String?
    var exhibitionImage: UIImage?
    var exhibitionImageURL: String?
    var galleryTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewContentTableView.delegate = self; reviewContentTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let animatedTabBar = self.tabBarController as? RAMAnimatedTabBarController else { return }
        animatedTabBar.animationTabBarHidden(true)
    }
    
    @IBAction func completionReview(_ sender: Any) {
        guard let ratingCell = reviewContentTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ReviewWriteViewRatingTableViewCell,
            let dateCell = reviewContentTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? ReviewWriteViewDateTableViewCell,
            let contentCell = reviewContentTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? ReviewWriteViewContentTableViewCell else { return }
        print(ratingCell.myRatingView.rating, dateCell.seeExhibitionDateTextField.text, contentCell.reviewContentTextView.text)
    }
    
    
}

extension ReviewWriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewWriteViewExhibitionInfoTitleTableViewCell", for: indexPath)
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewWriteViewExhibitionInfoTableViewCell.reuseIdentifier) as! ReviewWriteViewExhibitionInfoTableViewCell
            cell.exhibitionTitleLabel.text = exhibitionTitle
            if exhibitionImageURL == nil {
                cell.exhibitionImageView.image = exhibitionImage
            } else {
                cell.exhibitionImageView.imageFromUrl(gsno(exhibitionImageURL), defaultImgPath: "1")
            }
            cell.galleryTitleLabel.text = galleryTitle
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewWriteViewRatingTableViewCell.reuseIdentifier) as! ReviewWriteViewRatingTableViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewWriteViewDateTableViewCell.reuseIdentifier) as! ReviewWriteViewDateTableViewCell
            cell.initPickerView()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewWriteViewContentTableViewCell.reuseIdentifier) as! ReviewWriteViewContentTableViewCell
            cell.configure(viewHeight: self.view.frame.height)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewHeightRatio = UIScreen.main.bounds.height/667
        if indexPath.row == 0 {
            return viewHeightRatio*50
        } else if indexPath.row == 1 {
            return viewHeightRatio*111
        } else if indexPath.row == 2 {
            return viewHeightRatio*50
        } else if indexPath.row == 3 {
            return viewHeightRatio*50
        } else {
            return viewHeightRatio*270
        }
    }
}
