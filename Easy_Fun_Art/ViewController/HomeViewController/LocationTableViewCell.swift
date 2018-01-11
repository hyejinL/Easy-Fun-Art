//
//  LocationTableViewCell.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
//    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapViewFrame: UIView!
    var mapView: GMSMapView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configure(latitude: Double, longitude: Double) {
//        let location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        print(latitude, longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: mapViewFrame.frame.width, height: mapViewFrame.frame.height), camera: camera)
        print(mapViewFrame.frame)
        
//        mapView.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.map = mapView
        
        guard let mapview = mapView else { return }
        self.mapViewFrame.addSubview(mapview)
    }
}
