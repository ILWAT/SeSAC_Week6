//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/21.
//

import UIKit

//1. 객체 얹고, 레이아웃 잡고, 아웃렛 연결, 속성 연결

//1. 뷰 객체 프로퍼티 선언(클래스 인스턴스 생성)
//2. 명시적으로 루트뷰에 추가
//3. 크기와 위치 정의
//4. 속성 정의
//=> Frame 한계
//=> AutoResizingMask, AutoLayout => 스토리보드 대응
//=> NSLayoutConstraints => 코드베이스 대응
    //1. isActive()
    //2. addConstraints
//

class ViewController: UIViewController {
    
    let kakaoButton = {
        let button = UIButton()
        button.setTitle("KaKao Profile(example2) 보러가기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let textFieldButton = {
        let button = UIButton()
        button.setTitle("텍스트필드(Example1) 보러가기", for:  .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let theaterSearchButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.title = "주변 영화관 찾기"
        config.titleAlignment = .center
        config.imagePlacement = .leading
        config.image = UIImage(systemName: "popcorn.fill")
        config.imagePadding = 3
        button.configuration = config
        return button
    }()
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signedButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        
        emailTextField.frame = CGRect(x: 50, y: 80, width: Int(UIScreen.main.bounds.width-100), height: 50)
        
        emailTextField.backgroundColor = UIColor.lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "닉네임을 입력해주세요..?"
        
        //AutoLayout 설정
        //특별한게 없다면 multiplier는 1
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true //레이아웃 활성화
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
//        NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        //addConstraint
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50)
        
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
        
        view.addConstraints([leading, trailing, height, top])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.backgroundColor = .brown
        
        setLayoutAnchor()
        
        
        //숙제를 위한 추가 코드
        view.addSubViews([kakaoButton, textFieldButton,theaterSearchButton])
        setButtonLayout()
        kakaoButton.addTarget(self, action: #selector(tappedKakaoButton(_ :)), for: .touchUpInside)
        textFieldButton.addTarget(self, action: #selector(tappedTextFieldButton(_ :)), for: .touchUpInside)
        theaterSearchButton.addTarget(self, action: #selector(tappedtheatherButton), for: .touchUpInside)
        
    }
    
    func setLayoutAnchor(){
        view.addSubview(signedButton)
        
        signedButton.addTarget(self, action: #selector(tappedsignedButton), for: .touchUpInside)
        signedButton.translatesAutoresizingMaskIntoConstraints = false
        
        signedButton.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            signedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signedButton.widthAnchor.constraint(equalToConstant: 200),
            signedButton.heightAnchor.constraint(equalToConstant: 50),
            signedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor) //view.bottomAnchor는 SafeArea를 신경쓰지 않은 위치임 => view.safeAreaLayoutGuide.bottomAnchor
        ])
    }
    
    @objc func tappedsignedButton(){
        transition(viewController: GenericViewController.self, storyboard: "Main", style: .present)
    }

}



extension ViewController{
    func setButtonLayout(){
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: kakaoButton, attribute: .bottom, relatedBy: .equal, toItem: signedButton, attribute: .top, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: kakaoButton, attribute: .leading, relatedBy: .equal, toItem: signedButton, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: kakaoButton, attribute: .trailing, relatedBy: .equal, toItem: signedButton, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldButton, attribute: .leading, relatedBy: .equal, toItem: signedButton, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldButton, attribute: .trailing, relatedBy: .equal, toItem: signedButton, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textFieldButton, attribute: .bottom, relatedBy: .equal, toItem: kakaoButton, attribute: .top, multiplier: 1, constant: -10),
            kakaoButton.heightAnchor.constraint(equalToConstant: 50),
            textFieldButton.heightAnchor.constraint(equalToConstant: 50),
            theaterSearchButton.heightAnchor.constraint(equalToConstant: 50),
            NSLayoutConstraint(item: theaterSearchButton, attribute: .bottom, relatedBy: .equal, toItem: textFieldButton, attribute: .top, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: theaterSearchButton, attribute: .leading, relatedBy: .equal, toItem: textFieldButton, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: theaterSearchButton, attribute: .trailing, relatedBy: .equal, toItem: textFieldButton, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    @objc func tappedKakaoButton(_ sender: UIButton){
        let vc = KaKaoTalkProfileViewController()
        self.present(vc, animated: true)
    }
    
    @objc func tappedTextFieldButton(_ sender: UIButton){
        let vc = TextInputViewController()
        self.present(vc, animated: true)
    }
    @objc func tappedtheatherButton(_ sender: UIButton){
        let vc = TheaterViewController()
        self.present(vc, animated: true)
    }
    
}

