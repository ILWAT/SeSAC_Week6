//
//  TheaterViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/23.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class TheaterViewController: UIViewController {
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    let currentLocationButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "location.fill")
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        setUI()
    }
    
    func setUI(){
        self.view.addSubViews([mapView])
        self.mapView.addSubViews([currentLocationButton])
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
        }
        
        currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocationButton), for: .touchUpInside)
    }
    
    func checkDeviceAuthorization(){
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                let status: CLAuthorizationStatus
                
                if #available(iOS 14.0, *){
                    status = self.locationManager.authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                DispatchQueue.main.async {
                    self.checkLocationAuthorization(authorizationStatus: status)
                }
            }
        }
    }
    
    func checkLocationAuthorization(authorizationStatus: CLAuthorizationStatus){
        switch authorizationStatus{
        case .notDetermined:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denined")
            self.showAuthorizationAlert()
            self.setUserCurrentLocation()
        case .restricted:
            print("restricted")
            self.showAuthorizationAlert()
            self.setUserCurrentLocation()
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        @unknown default:
            print("UnknownLocationAuthorization")
        }
    }
    
    func showAuthorizationAlert(){
        let alert = UIAlertController(title: "권한 허용이 필요합니다.", message: "위치 서비스를 사용할 수 없습니다.\n기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정 이동", style: .default) { _ in
            if let settingURL = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(settingURL)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    func setUserCurrentLocation(_ coordinate: CLLocationCoordinate2D? = nil){
        let region: MKCoordinateRegion
        let point: MKPointAnnotation
        
        if let coordinate {
            point = MKPointAnnotation()
            point.coordinate = coordinate
            point.title = "현재 위치"
            
            region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        } else {
            //SeSAC 영등포 캠퍼스 좌표 : 37.517829, 126.886270
            let defaultLocation = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
            point = MKPointAnnotation()
            point.title = "기본 위치"
            point.coordinate = CLLocationCoordinate2D(latitude: defaultLocation.latitude, longitude: defaultLocation.longitude)
            
            region = MKCoordinateRegion(center: defaultLocation, latitudinalMeters: 400, longitudinalMeters: 400)
        }
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(point)
        
    }
    
    
    //MARK: - Helper
    @objc func tappedCurrentLocationButton(_ sender: UIButton){
        checkDeviceAuthorization()
    }
}

extension TheaterViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {return}
        setUserCurrentLocation(location)
        locationManager.stopUpdatingLocation() //현재 위치를 가져왔으니 가져오기를 중단하자.
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceAuthorization() //권한이 변경되었으니 다시 처음부터 재확인하자
    }
}

