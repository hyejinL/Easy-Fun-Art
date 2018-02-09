//
//  SearchResultViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet weak var noSearchDataView: UIView!
    
    var searchList = [SearchList.SearchData]()
    var period = 1
    var order = 0
    var searchText = ""
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        textFieldFirstSetting()
        
        noSearchDataView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(pressedLikeIt), name: NSNotification.Name("likeExhibition"), object: nil)
        self.createSearchbar()
        self.setUpCollectionView()
        self.searchTextField.text = searchText
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.loading(.start)
        self.getSearchList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.9097052217, blue: 0, alpha: 1)
    }
    
    //MARK: CollectionView Setting
    func setUpCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: MainRecoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier)
    }
    
    //MARK: Networking
    func getSearchList(){
        SearchService.shareInstance.search(qString: gsno(searchTextField.text), period: self.period, order: self.order) { (res) in
            switch res {
            case .success(let searchList):
                self.loading(.end)
                self.searchList = searchList
                if searchList.isEmpty {
                    self.noSearchDataView.isHidden = false
                } else {
                    self.noSearchDataView.isHidden = true
                }
                self.collectionView.reloadData()
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
    
    @IBAction func touchUpSearchButton(_ sender: UIBarButtonItem) {
        self.getSearchList()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchTextField.resignFirstResponder()
    }
    
    @objc func goDocentPopUp(_ button: UIButton) {
        let docentPlayListTableViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
        guard let cell = button.superview?.superview?.superview as? MainRecoCollectionViewCell else { return }
        
        docentPlayListTableViewController.exhibitionId = cell.exhibitionId
        docentPlayListTableViewController.exhibitionTitle = cell.exhibitionTitleLabel.text
        docentPlayListTableViewController.exhibitionImage = cell.exhibitionImageURL
        
        self.navigationController?.pushViewController(docentPlayListTableViewController, animated: true)
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
    
    @objc func pressedLikeIt(_ notification: Notification) {
        
        guard let like = notification.userInfo?["like"] as? Int else { return }
        
        if like == 1 {
            let likeViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LikeViewController.reuseIdentifier) as! LikeViewController
            let exhibitionText = notification.userInfo?["exhibitionText"] as? String
            
            likeViewController.exhibitionText = exhibitionText
            self.present(likeViewController, animated: true, completion: nil)
        }
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func createSearchbar() {
        searchTextField.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: 35)
        navigationItem.titleView = searchTextField
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainRecoCollectionViewCell.reuseIdentifier, for: indexPath) as! MainRecoCollectionViewCell
        
        cell.goDocentButton.addTarget(self, action: #selector(goDocentPopUp), for: .touchUpInside)
        cell.goExhibitionDetailView.addTarget(self, action: #selector(goExhibitionDetailViewAtCellButton(_:)), for: .touchUpInside)
        
        cell.exhibitionImageView.imageFromUrl(gsno(searchList[indexPath.row].ex_image), defaultImgPath: "1")
        cell.exhibitionId = gino(searchList[indexPath.row].ex_id)
        cell.exhibitionRatingView.rating = Double(gfno(searchList[indexPath.row].ex_average_grade))
        cell.exhibitionRatingLabel.text = String(format: "%.01f", gfno(searchList[indexPath.row].ex_average_grade))
        cell.exhibitionTitleLabel.text = searchList[indexPath.row].ex_title
        cell.exhibitionDateLabel.text = "\(gsno(searchList[indexPath.row].ex_start_date)) ~ \(gsno(searchList[indexPath.row].ex_end_date))"
        cell.exhibitionLocationLabel.text = searchList[indexPath.row].gallery_name
        cell.ratingViewWidth.constant = CGFloat(gfno(searchList[indexPath.row].ex_average_grade)/5)*55
        
        if gino(searchList[indexPath.row].likeFlag) == 1 {
            cell.likeButton.isChecked = true
        } else {
            cell.likeButton.isChecked = false
        }
        
        return cell
        
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout{
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: self.view.frame.width, height: 56*self.view.frame.height/667)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 175*self.view.frame.height/667)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

extension SearchResultViewController: UITextFieldDelegate{
    
    func textFieldFirstSetting() {
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:)))
        self.view.addGestureRecognizer(backgroundTap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if gino(searchTextField.text?.count) < 2 {
            simpleAlert(title: "검색 오류", msg: "두 글자 이상 입력해주세요 :)")
        } else {
            loading(.start)
            getSearchList()
        }
        return true
    }
    
    @objc func tapBackground(_ sender: UITapGestureRecognizer?) {
        self.searchTextField.resignFirstResponder()
    }
    
}


