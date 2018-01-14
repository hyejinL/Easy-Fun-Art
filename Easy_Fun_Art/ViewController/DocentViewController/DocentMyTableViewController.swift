//
//  DocentMyTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DocentMyTableViewController: UITableViewController, IndicatorInfoProvider {

    var playListData = [HomeExhibition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpTableView()
        
        loading(.start)
        updatePlayList()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "찜한 전시")
    }
    
    func updatePlayList() {
        DocentService.shareInstance.likeExhibitionList() { (result) in
            switch result {
            case .success(let listData):
                self.loading(.end)
                self.playListData = listData
                self.tableView.reloadData()
                break
            case .error(let msg):
                print(msg)
                break
            }
        }
    }

}



extension DocentMyTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: DocentListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DocentListTableViewCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension DocentMyTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocentListTableViewCell.reuseIdentifier, for: indexPath) as! DocentListTableViewCell
        
        cell.exhibitionId = gino(playListData[indexPath.row].ex_id)
        cell.exhibitionImageView.imageFromUrl(gsno(playListData[indexPath.row].ex_image), defaultImgPath: "1")
        cell.exhibitionTitleLabel.text = playListData[indexPath.row].ex_title
        cell.galleryNameLabel.text = playListData[indexPath.row].gallery_name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docentPlayListViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayListTableViewController.reuseIdentifier) as! DocentPlayListTableViewController
        
        docentPlayListViewController.exhibitionId = gino(playListData[indexPath.row].ex_id)
        docentPlayListViewController.exhibitionImage = playListData[indexPath.row].ex_image
        docentPlayListViewController.exhibitionTitle = playListData[indexPath.row].ex_title
        
        self.navigationController?.pushViewController(docentPlayListViewController, animated: true)
    }
}

