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
    
    //카메라 피커
    //1.
    let picker = UIImagePickerController()
    
    //    lazy var photoImageView = {
    //        let view = UIImageView()
    //        view.backgroundColor = .systemMint
    //        view.contentMode = .scaleAspectFill
    //        return view
    //    }()
    
    let photoImageView = {
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
        
        //        view.addSubview(photoImageView)
        //        view.addSubview(titleTextField)
        //
        //        for item in [photoImageView, titleTextField]{
        //            view.addSubview(item)
        //        }
        
        [photoImageView, titleTextField].forEach({ item in
            view.addSubview(item)
        })
        view.backgroundColor = .white
        
        picker.delegate = self
        
        setupConstraints()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //2. available
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿")
            return
        }
        
        picker.delegate = self
        picker.navigationController?.delegate = self
        picker.sourceType = .camera //.photoLibrary
        picker.allowsEditing = true //편집을 허용함
        present(picker, animated: true)
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

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //취소 버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print(#function)
    }
    
    //사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoImageView.image = image
            dismiss(animated: true)
        }
    }
}
