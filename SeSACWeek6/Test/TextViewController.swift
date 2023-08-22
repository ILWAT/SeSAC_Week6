//
//  TextViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
//    lazy var photoImageView = setImageView()
    
    lazy var photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        
        for item in [photoImageView, titleTextField]{
            view.addSubview(photoImageView)
        }
        
        [photoImageView, titleTextField].forEach({ item in
            view.addSubview(item)
        })
        
        setupConstraints()
    }
    
    func setImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .systemMint
        view.contentMode = .scaleAspectFill
        return view
    }
    
    func setupConstraints(){
        //top, leading, trailing은 0으로 맞추기, 높이는 200
        photoImageView.snp.makeConstraints { make in
            make.height.equalTo(self.view).multipliedBy(0.3)
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    


}
