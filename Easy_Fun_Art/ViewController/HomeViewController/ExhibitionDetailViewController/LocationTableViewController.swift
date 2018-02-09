//
//  LocationTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var galleryInfo: GalleryDetail.GalleryDetailData?
    var id = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView(frame: .zero)
        
        galleryInfoUpdate()
    }
    
    func galleryInfoUpdate() {
        HomeService.shareInstance.galleryDetail(galleryId: id) { (result) in
            switch result {
            case .success(let galleryData):
                self.galleryInfo = galleryData
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

extension LocationTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as! LocationTableViewCell

        cell.timeLabel.text = galleryInfo?.runtime
        cell.addressLabel.text = galleryInfo?.address
        cell.numberLabel.text = galleryInfo?.phone
        if let latitude = galleryInfo?.latitude, let longitude = galleryInfo?.longitude {
            cell.configure(latitude: latitude, longitude: longitude)
        }

        return cell
    }

}
