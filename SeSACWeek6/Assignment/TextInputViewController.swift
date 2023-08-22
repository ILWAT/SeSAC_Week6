//
//  TextInputViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/22.
//

import UIKit
import SnapKit

class TextInputViewController: UIViewController {
    

    let grayView = {
        let uiView = UIView()
        uiView.backgroundColor = .systemGray
        return uiView
    }()
    
    let titleTextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        return textField
    }()
    
    let dateTextField = {
        let textField = UITextField()
        textField.placeholder = "날짜를 입력해주세요."
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        return textField
    }()
    
    let resultTextView = {
        let textView = UITextView()
        textView.text = ""
        textView.isEditable = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubViews([grayView,titleTextField, dateTextField, resultTextView])
        self.view.backgroundColor = .white
        
//        setUI()
        setConstraints()
    }
    
//    func setUI(){
//        
//    }
    
    func setConstraints(){
        grayView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(grayView)
            make.height.equalTo(50)
        }
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(grayView)
            make.height.equalTo(50)
        }
        resultTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(grayView)
        }
        
    }
    

}
