//
//  DocentAroundTableViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 1..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreLocation

class DocentAroundTableViewController: UITableViewController, IndicatorInfoProvider {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var playListData = [HomeExhibition]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager = CLLocationManager()
//        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            guard let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude else { return }
            updatePlayList(latitude: Float(latitude), longitude: Float(longitude))
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "내 주변 전시")
    }
    
    func updatePlayList(latitude: Float, longitude: Float) {
        DocentService.shareInstance.locationExhibitionList(latitude: latitude, longitude: longitude) { (result) in
            switch result {
            case .success(let listData):
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

extension DocentAroundTableViewController {
    func setUpTableView() {
        self.tableView.register(UINib(nibName: DocentListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DocentListTableViewCell.reuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension DocentAroundTableViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print(location.coordinate.latitude, location.coordinate.longitude)
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == CLAuthorizationStatus.denied {
//            showLocationDisableAlert()
//        }
//    }
    
    func showLocationDisableAlert() {
        let alertController = UIAlertController(title: "위치 접근이 제한되었습니다.", message: "내 주변 전시를 보기 위해 위치 정보가 필요합니다.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let openAction = UIAlertAction(title: "설정으로 가기", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension DocentAroundTableViewController {
    
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
        self.navigationController?.pushViewController(docentPlayListViewController, animated: true)
    }
}
