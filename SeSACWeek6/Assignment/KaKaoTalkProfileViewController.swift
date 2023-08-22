//
//  KaKaoTalkProfileViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/22.
//

import UIKit

class KaKaoTalkProfileViewController: UIViewController {
    
    let imageStrArray = ["doughnut","icecream","churros","macaroon","cake"]

    let separateView = UIView()
    
    let backgroundImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let profileImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let cancelButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let qrButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "qrcode"), for: .normal)
        return button
    }()
    
    let giftButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gift.circle"), for: .normal)
        return button
    }()
    
    let settingButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        return button
    }()
    
    
    let talkmyselfButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        button.setTitle("나와의 채팅", for: .normal)
        return button
    }()
    
    let editProfileButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setTitle("프로필 편집", for: .normal)
        return button
    }()
    
    
    let storyButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "quote.closing"), for: .normal)
        button.setTitle("카카오스토리", for: .normal)
        return button
    }()
    
    let bottomStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI("jack", "안녕하세요")
    }
    
    func setUI(_ name: String, _ description: String){
        bottomStackView.addArrangedSubview(talkmyselfButton)
        bottomStackView.addArrangedSubview(editProfileButton)
        bottomStackView.addArrangedSubview(storyButton)
        
        view.addSubViews([backgroundImageView, profileImageView, separateView, cancelButton, qrButton, settingButton, giftButton, bottomStackView, nameLabel, descriptionLabel])
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.image = UIImage(named: imageStrArray.randomElement()!)
        backgroundImageView.image = UIImage(named: imageStrArray.randomElement()!)
        
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        nameLabel.text = name
        descriptionLabel.text = description
        
        separateView.backgroundColor = .white
        
        setButtonUI([cancelButton, giftButton, qrButton, settingButton,talkmyselfButton, editProfileButton, storyButton])
        
        setConstraints()
    }
    
    
    //MARK: - SetUI&Data
    func setButtonUI(_ buttons: [UIButton]){
        for item in buttons{
            item.tintColor = .white
            
            var config = UIButton.Configuration.filled()
            config.imagePlacement = .top
            config.titleAlignment = .center
            config.baseBackgroundColor = .clear
            
            item.configuration = config
            
        }
    }
    
    func setConstraints(){
        backgroundImageView.snp.makeConstraints { make in
            make.size.equalTo(self.view)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(cancelButton.snp.width)
            make.width.equalTo(20)
        }
        settingButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(cancelButton.snp.width)
            make.width.equalTo(20)
            make.centerY.equalTo(cancelButton)
        }
        qrButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingButton.snp.leading).offset(-10)
            make.height.equalTo(cancelButton.snp.width)
            make.width.equalTo(20)
            make.centerY.equalTo(cancelButton)
        }
        giftButton.snp.makeConstraints { make in
            make.centerY.equalTo(cancelButton)
            make.height.equalTo(cancelButton.snp.width)
            make.width.equalTo(20)
            make.centerY.equalTo(cancelButton)
            make.trailing.equalTo(qrButton.snp.leading).offset(-10)
        }
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        separateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomStackView.snp.top).offset(-10)
            make.height.equalTo(1)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(separateView.snp.top).offset(-10)
            make.trailing.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalTo(profileImageView.snp.centerX)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.centerX.equalTo(profileImageView.snp.centerX)
            make.trailing.leading.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(5)
            make.top.equalTo(profileImageView.snp.bottom)
        }
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalTo(profileImageView.snp.height)
            make.bottom.equalTo(nameLabel.snp.top)
        }
        
        
    }
    
    

}
