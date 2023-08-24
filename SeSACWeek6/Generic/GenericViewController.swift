//
//  GenericViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit

class GenericViewController: UIViewController {
    let sampleLabel = UILabel()
    let sampleButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "네비게이션 타이틀"
        
        view.addSubViews([sampleLabel, sampleButton])
        
        sampleLabel.backgroundColor = .yellow
        sampleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        
        sampleButton.backgroundColor = .green
        sampleButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(sampleLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        
        let generic = sum(a: 3.344, b: 4.77)
        let generic2 = sum(a: 22, b: 88)

        let value = sumInt(a: 3, b: 7)
        print(value)
        
        let value2 = sumDouble(a: 3.3, b: 7.7)
        print(value2)
    }


}
