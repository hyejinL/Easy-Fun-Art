//
//  DocentPlayListTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class DocentPlayListTableViewController: UITableViewController, PlayerIsOn {
    @IBOutlet var docentListMessageView: UIView!
    @IBOutlet weak var docentListMessageImageView: UIImageView!
    @IBOutlet weak var docentListMessageLabel: UILabel!
    
    var exhibitionId = -1
    var docentListData: Docent.DocentData?
    var floor = [String:Int]()
    var floorString = [String]()
    var trackIdList = [Int]()
    var exhibitionTitle: String?
    var exhibitionImage: String?
    var selectedIndexPath = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
        self.navigationController?.navigationBar.isHidden = false
        
        loading(.start)
        docentListUpdate()
        
        self.view.addSubview(docentListMessageView)
        docentListMessageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func docentListImageChange(indexPath: Int) {
        selectedIndexPath = indexPath
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return floor.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        for (i, element) in floorString.enumerated() {
            if section == i {
                return gino(floor[element])
            }
        }
        return 0
    }
    
    func docentListUpdate() {
        print(exhibitionId)
        DocentService.shareInstance.docentList(exhibitionId: exhibitionId) { (result) in
            switch result {
            case .success(let docentList):
                self.loading(.end)
                self.docentListData = docentList
                
                self.docentListMessageView.frame = self.view.frame
                if docentList.ex_state == 0 {
                    self.docentListMessageImageView.isHidden = false
                    self.docentListMessageImageView.image = #imageLiteral(resourceName: "img_popup_docent_end")
                    self.docentListMessageLabel.text = "이미 끝난 전시는\n도슨트를 제공하지 않아요 :-)"
                } else if docentList.ex_state == 1 {
                    self.docentListMessageView.isHidden = true
                } else if docentList.ex_state == 2 {
                    self.docentListMessageImageView.isHidden = false
                    self.docentListMessageImageView.image = #imageLiteral(resourceName: "img_popup_docent_wait")
                    self.docentListMessageLabel.text = "아직 진행 중인 전시가 아니에요\n도슨트를 준비 중입니다!"
                }
                
                for docent in docentList.docentDataResult {
                    
                    self.trackIdList.append(self.gino(docent.docent_track))
                    
                    if self.floor[self.gsno(docent.docent_floor)] != nil {
                        guard let floorValue = self.floor[self.gsno(docent.docent_floor)] else { return }
                        self.floor[self.gsno(docent.docent_floor)] = floorValue+1
                    } else {
                        self.floor[self.gsno(docent.docent_floor)] = 1
                        self.floorString.append(self.gsno(docent.docent_floor))
                    }
                }
                print(self.floor, self.floorString)
                
                self.tableView.reloadData()
                
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
}

extension DocentPlayListTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: DocentPlayListHeaderCell.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: DocentPlayListHeaderCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension DocentPlayListTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DocentPlayListHeaderCell.reuseIdentifier) as! DocentPlayListHeaderCell
        
        headerView.docentListFloorLabel.text = floorString[section]
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DocentPlayListTableViewCell.reuseIdentifier, for: indexPath) as! DocentPlayListTableViewCell
        
        cell.docentListNumberLabel.text = String(format: "%02d", indexPath.row+1)
        
        var index = 0
        if indexPath.section != 0 {
            for i in 0...indexPath.section-1 {
                index += gino(floor[floorString[i]])
            }
        }
        
        if index == selectedIndexPath {
            cell.docentListCurrentPlayImageView.image = #imageLiteral(resourceName: "btn_docentlist_playing")
        } else {
            cell.docentListCurrentPlayImageView.image = #imageLiteral(resourceName: "btn_docentlist_play")
        }
        print(docentListData?.docentDataResult[index+indexPath.row].docent_title)
        cell.docentListTitleLabel.text = docentListData?.docentDataResult[index+indexPath.row].docent_title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let docentPlayerViewController = UIStoryboard(name: "Docent", bundle: nil).instantiateViewController(withIdentifier: DocentPlayerViewController.reuseIdentifier) as! DocentPlayerViewController
        
        docentPlayerViewController.delegate = self
        
        docentPlayerViewController.exhibitionId = exhibitionId
        var index = 0
        if indexPath.section != 0 {
            for i in 0...indexPath.section-1 {
                index += gino(floor[floorString[i]])
            }
        }
        docentPlayerViewController.trackId = gino(docentListData?.docentDataResult[index+indexPath.row].docent_track)
        docentPlayerViewController.index = index
        docentPlayerViewController.trackIdList = self.trackIdList
        docentPlayerViewController.exhibitionTitle = self.exhibitionTitle
        docentPlayerViewController.exhibitionImage = self.exhibitionImage
        
        self.present(docentPlayerViewController, animated: true, completion: nil)
    }
}
