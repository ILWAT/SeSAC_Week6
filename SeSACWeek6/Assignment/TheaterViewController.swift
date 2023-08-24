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
    //MARK: - Properties
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
    
    let theaterCenterbutton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "popcorn.fill")
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    let constraintSearchButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "magnifyingglass")
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        setUI()
    }
    
    
    //MARK: - setScene
    func setUI(){
        self.view.addSubViews([mapView])
        self.mapView.addSubViews([currentLocationButton, theaterCenterbutton, constraintSearchButton])
        
        currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocationButton), for: .touchUpInside)
        theaterCenterbutton.addTarget(self, action: #selector(tappedTheaterCenterButton), for: .touchUpInside)
        constraintSearchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        
        setConstraints()
    }
    
    func setConstraints(){
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
        }
        theaterCenterbutton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        constraintSearchButton.snp.makeConstraints { make in
            make.top.equalTo(theaterCenterbutton.snp.bottom)
            make.leading.equalTo(theaterCenterbutton)
        }
    }
    //MARK: - Mapkit
    
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
        showTheaterAnnotation()
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
    
    func showTheaterAnnotation(constraint: String? = nil){
        let theaterData = TheaterList()
        var theaterAnnotation: [MKAnnotation] = []
        
        mapView.removeAnnotations(mapView.annotations)
        
        if let constraint { //설정된 조건이 있다면 조건에 맞는 영화관만 보인다.
            theaterData.mapAnnotations.forEach { theater in
                if theater.type == constraint{
                    let annotation = MKPointAnnotation()
                    annotation.coordinate.latitude = theater.latitude
                    annotation.coordinate.longitude = theater.longitude
                    annotation.title = theater.location
                    theaterAnnotation.append(annotation)
                }
            }
        } else { //설정 조건이 없다면 모든 영화관을 보인다.
            theaterData.mapAnnotations.forEach { Theater in
                let annotation = MKPointAnnotation()
                annotation.coordinate.latitude = Theater.latitude
                annotation.coordinate.longitude = Theater.longitude
                annotation.title = Theater.location
                theaterAnnotation.append(annotation)
            }
        }
        mapView.addAnnotations(theaterAnnotation)
    }
    
    
    //MARK: - ButtonAction
    @objc func tappedCurrentLocationButton(_ sender: UIButton){
        checkDeviceAuthorization()
    }
    
    @objc func tappedTheaterCenterButton(_ sender: UIButton){
        //중간 지점 예상 : 상도역(37.503664, 126.948264)
        let theaterCenter = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.503664, longitude: 126.948264), latitudinalMeters: 15000, longitudinalMeters: 15000)
        
        mapView.setRegion(theaterCenter, animated: true)
    }
    
    @objc func tappedSearchButton(_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let theaterCase = TheaterType.allCases
        
        theaterCase.forEach { type in
            let title = type.rawValue
            let alertAction = UIAlertAction(title: title, style: .destructive) { _ in
                self.showTheaterAnnotation(constraint: type.getConstraintValue)
            }
            alert.addAction(alertAction)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //MARK: - Helper
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
}


//MARK: - Extension, CLLocationDelegate
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

