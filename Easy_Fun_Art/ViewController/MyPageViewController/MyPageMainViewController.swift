//
//  MyPageMainViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 6..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class MyPageMainViewController: UIViewController {

    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var myNicknameLabel: UILabel!
    @IBOutlet weak var myLikeCountLabel: UILabel!
    @IBOutlet weak var myReviewCountLabel: UILabel!
    @IBOutlet weak var myRatingCountLabel: UILabel!
    @IBOutlet weak var changePreferenceButton: UIButton!
    @IBOutlet weak var myHashtagCollectionView: UICollectionView!
    @IBOutlet weak var myHashtagCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreMyHashtagButton: UIButton!
    @IBOutlet weak var myExhibitionCollectionView: UICollectionView!
    @IBOutlet weak var myReviewTableView: UITableView!
    @IBOutlet weak var myReviewTableViewHeight: NSLayoutConstraint!
    
    var userData: User.UserData?
    let genre = ["동양화", "서양화", "도예", "금속", "일러스트", "목공", "현대미술", "팝아트", "풍경화", "카툰", "인물화", "사진전"]
    let mood = ["적막감", "환상적인", "세련된", "편안한", "강렬한", "따뜻한", "슬픈", "유유자적한", "우아한", "시원한", "사실적인"]
    let topic = ["모험", "코믹", "범죄", "판타지", "픽션", "공포/스릴러", "미스터리", "철학", "정치", "사랑", "풍자", "과학"]
    let place = ["서촌", "강남", "홍대/합정", "인사동", "이태원", "충무로", "혜화/대학로", "삼청동/북촌", "기타"]
    var hashtag = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changePreferenceButton.layer.cornerRadius = changePreferenceButton.frame.height/2
        
        myHashtagCollectionView.delegate = self; myHashtagCollectionView.dataSource = self
        myExhibitionCollectionView.delegate = self; myExhibitionCollectionView.dataSource = self
        myReviewTableView.delegate = self; myReviewTableView.dataSource = self
        
        myHashtagCollectionView.collectionViewLayout = LeftAlignedFlowLayout()
        
        setCollectionTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        userDataUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func profileChangeButton(_ sender: Any) {
        
    }
    
    @IBAction func nicknameChangeButton(_ sender: Any) {
        let nicknameChangeViewController = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: NicknameChangeViewController.reuseIdentifier) as! NicknameChangeViewController
        self.tabBarController?.present(nicknameChangeViewController, animated: true, completion: nil)
    }
    
    @IBAction func pressedMoreMyHashtag(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.myHashtagCollectionViewHeight.constant = self.myHashtagCollectionView.contentSize.height
            self.moreMyHashtagButton.removeFromSuperview()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func pressedMoreReview(_ sender: Any) {
        
    }
    
    func userDataUpdate() {
        MyPageService.shareInstance.myPageUpdate { (result) in
            switch result {
            case .success(let user):
                
                self.userData = user
                
                self.myNicknameLabel.text = user.user_data.user_nickname
                self.myProfileImageView.imageFromUrl(self.gsno(user.user_data.user_profile), defaultImgPath: "img_profie_basic")
                self.myLikeCountLabel.text = "\(self.gino(user.user_Like_Count))"
                self.myReviewCountLabel.text = "\(self.gino(user.user_Review_Count))"
                self.myRatingCountLabel.text = "\(self.gino(user.user_Grade_Count))"
                
                let userGenre = user.user_data.user_genre
                print(userGenre)
                let userPlace = user.user_data.user_place
                let userMood = user.user_data.user_mood
                let userTopic = user.user_data.user_subject
                
                let group = DispatchGroup()
                let q1 = DispatchQueue(label: "hashtag")
                q1.async(group: group){
                    self.hashtag = []
                    for (i, element) in userGenre.enumerated() {
                        if element == 1 {
                            self.hashtag.append(self.genre[i])
                        }
                    }
                    for (i, element) in userPlace.enumerated() {
                        if element == 1 {
                            self.hashtag.append(self.place[i])
                        }
                    }
                    for (i, element) in userMood.enumerated() {
                        if element == 1 {
                            self.hashtag.append(self.mood[i])
                        }
                    }
                    for (i, element) in userTopic.enumerated() {
                        if element == 1 {
                            self.hashtag.append(self.topic[i])
                        }
                    }
                    
                }
                
                group.notify(queue: DispatchQueue.main){
                    print("dddd")
                    print(self.hashtag.count)
                    self.myHashtagCollectionView.reloadData()
                }
                
                self.myExhibitionCollectionView.reloadData()
                self.myReviewTableView.reloadData()
                
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }
    
    func profileChange() {
        
    }
}

extension MyPageMainViewController {
    func setCollectionTableView() {
        myHashtagCollectionView.register(UINib(nibName: MyHashtagCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MyHashtagCollectionViewCell.reuseIdentifier)
        myReviewTableView.register(UINib(nibName: MyReviewTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MyReviewTableViewCell.reuseIdentifier)
        if let flowLayout = self.myHashtagCollectionView.collectionViewLayout as? LeftAlignedFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}

extension MyPageMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myHashtagCollectionView {
            print("number of item : ", hashtag.count)
            return hashtag.count
        } else {
            return gino(userData?.user_Like_List.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myExhibitionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyExhibitionCollectionViewCell.reuseIdentifier, for: indexPath) as! MyExhibitionCollectionViewCell
            
            cell.myExhibitionImageView.imageFromUrl(gsno(userData?.user_Like_List[indexPath.row].ex_image), defaultImgPath: "1")
            cell.myExhibitionTitleLabel.text = userData?.user_Like_List[indexPath.row].ex_title
            cell.exhibitionId = gino(userData?.user_Like_List[indexPath.row].ex_id)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyHashtagCollectionViewCell.reuseIdentifier, for: indexPath) as! MyHashtagCollectionViewCell
            print(hashtag.count, indexPath.row)
            cell.hashtaglabel.text = hashtag[indexPath.row]
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
            return cell
        }
    }
}

extension MyPageMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myHashtagCollectionView {
            return 10
        } else {
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myHashtagCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == myExhibitionCollectionView {
            return UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
        } else {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        }
    }
}

extension MyPageMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gino(userData?.user_Review_List.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyReviewTableViewCell.reuseIdentifier) as! MyReviewTableViewCell
        return cell
    }
}
