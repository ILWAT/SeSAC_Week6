//
//  BlackRadiusTxtField.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit

//반복되는 코드를 깔끔하게 만들기 위해서 커스텀 텍스트필드로 제작
class BlackRadiusTextField: UITextField {
    
    //Interface Builder를 사용하지 않고, UIView를 상속 받은 Custom Class를 코드로 구성할 때 사용되는 초기화 구문
    override init(frame: CGRect) { //UIView에서 재정의하는 Override
        super.init(frame: frame)
        setupView()
    }
    
    //required: 프로토콜에서 생성된 경우 사용하는 키워드
    //Required Initializer
    //NScoding
    //XIB -> NIB 변환 과정에서 객체 생성 시 필요한 init 구문 (storyboard)
    //Interface Builder에서 생성된 뷰들이 초기화될 때 실행되는 구문
    //코드 기반 화면구성에서 초기화를 진행했을 때에는 required init이 필요하지 않기 때문에 옵셔널로 메서드를 생성한다.
    required init?(coder: NSCoder) { //NScoding : Protocol
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        font = .boldSystemFont(ofSize: 15)
        textColor = .black
        textAlignment = .center
    }
}

protocol ExampleProtocol {
    init(name: String)
}

class Mobile: ExampleProtocol{
    required init(name: String) {
        
    }
}
