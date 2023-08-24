//
//  CustomViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit
import SnapKit


class CustomViewController: UIViewController {
    
    let idTextField = {
        let textField = BlackRadiusTextField()
        textField.placeholder = "아이디를 입력해주세요."
        return textField
    }()
    
    let pwTextField: UITextField = {
        let textField = BlackRadiusTextField()
        textField.placeholder = "비밀번호를 입력해주세요."
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubViews([idTextField, pwTextField])
        
        idTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
    }
    



}
