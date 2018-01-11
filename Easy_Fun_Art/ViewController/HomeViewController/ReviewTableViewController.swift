//
//  ReviewTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 10..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

struct Rating {
    let rating: Int
    let count: Int
    
    init(rating: Int, count: Int) {
        self.rating = rating
        self.count = count
    }
}

class ReviewTableViewController: UITableViewController {
    var reviewInfo: ExhibitionReview.ReviewData?
    var exhibitionId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loading(.start)
        reviewUpdate()
    }
    
    func reviewUpdate() {
        HomeService.shareInstance.exhibitionReview(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let reviewData):
                self.loading(.end)
                self.reviewInfo = reviewData
                print(self.reviewInfo)
                self.tableView.reloadData()
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
}

extension ReviewTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: ReviewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: ExhibitionReviewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ExhibitionReviewTableViewCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension ReviewTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return gino(reviewInfo?.latestReview.count)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as! ReviewTableViewCell
            
            cell.ratingScoreLabel.text = String(format: "%.01f", gfno(reviewInfo?.reviewGraph.averageGrade))
            cell.ratingCountLabel.text = "\(gino(reviewInfo?.reviewGraph.totalGradeCount)) 명"
            let rating1 = Rating(rating: 1, count: gino(reviewInfo?.reviewGraph.grade_1))
            let rating2 = Rating(rating: 2, count: gino(reviewInfo?.reviewGraph.grade_2))
            let rating3 = Rating(rating: 3, count: gino(reviewInfo?.reviewGraph.grade_3))
            let rating4 = Rating(rating: 4, count: gino(reviewInfo?.reviewGraph.grade_4))
            let rating5 = Rating(rating: 5, count: gino(reviewInfo?.reviewGraph.grade_5))
            cell.configure(count: gino(reviewInfo?.reviewGraph.totalGradeCount), rating: [rating1, rating2, rating3, rating4, rating5])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExhibitionReviewTableViewCell.reuseIdentifier, for: indexPath) as! ExhibitionReviewTableViewCell
            
            cell.userProfileImageView.imageFromUrl(gsno(reviewInfo?.latestReview[indexPath.row].user_profile), defaultImgPath: "img_profile_basic-1")
            cell.writerLabel.text = reviewInfo?.latestReview[indexPath.row].user_nickname
            cell.ratingView.rating = Double(gino(reviewInfo?.latestReview[indexPath.row].review_grade))
            cell.previewDateLabel.text = reviewInfo?.latestReview[indexPath.row].review_watch_date
            cell.reviewContentLabel.text = reviewInfo?.latestReview[indexPath.row].review_content
            if let reviewImage = reviewInfo?.latestReview[indexPath.row].review_image {
                if reviewImage.isEmpty {
                    cell.reviewImageView.isHidden = true
                } else {
                    cell.reviewImageView.imageFromUrl(reviewImage, defaultImgPath: "")
                }
            }
            cell.dateLabel.text = "\(reviewInfo?.latestReview[indexPath.row].review_date)일 작성"
            
            return cell
        }
    }
}

