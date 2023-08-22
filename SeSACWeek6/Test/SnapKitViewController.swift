//
//  SnapKitViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/22.
//

import UIKit
import SnapKit

/*
addSubView
superView
offset inset
RTL LTR
 */

class SnapKitViewController: UIViewController {
    
    let redView = UIView()
    let whiteView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        redView.backgroundColor = .red
        whiteView.backgroundColor = .white
        blueView.backgroundColor = .blue
        yellowView.backgroundColor = .yellow
        
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            
//            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
//            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        view.addSubview(blueView)
        blueView.snp.makeConstraints { make in
//            make.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
            make.center.equalTo(self.view.safeAreaLayoutGuide)
//            make.width.height.equalTo(200)
            make.size.equalTo(200) // size = width.height
        }
        blueView.addSubview(yellowView)
        
//        view.addSubview(yellowView)
        yellowView.snp.makeConstraints { make in
//            make.size.equalTo(150)
//            make.leading.top.equalToSuperview()
            
//            make.leading.top.trailing.bottom.equalToSuperview()
            make.edges.equalTo(blueView).inset(50)
        }
        
    }
    
}
