//
//  CustomTableViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit
import SnapKit

struct Sample {
    let text: String
    var isExpand: Bool
}

class CustomTableViewController: UIViewController {
    
    //viewDidLoad보다 클로저 구문이 먼저 실행이 됨. => Break Point를 활용한 순서 확인
    //CustomTableViewControlledr 인스턴스 생성 직전에 클로저 구문이 우선 실행
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension //높이 유동적 설정
        view.delegate = self //자기 자신의 인스턴스
        view.dataSource = self
        //UINib -> Xib
        view.register(CustomTableViewTableViewCell.self, forCellReuseIdentifier: "customCell")
        return view
    }()
    
    let imageView = {
        let view = PosterImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        return view
    }()

//    var isExpand = false //false = 2줄 표시 / true = 무한대 표시
    var list: [Sample] = [Sample(text: "테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트", isExpand: false), Sample(text: "테스트 셀 텍스트테스트 셀 ", isExpand: false), Sample(text: " 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트테스트 셀 텍스트", isExpand: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        
        
//        tableView.delegate = self //자기 자신의 인스턴스
//        tableView.dataSource = self
//        //UINib -> Xib
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
//        tableView.register(CustomTableViewController.self, forCellReuseIdentifier: "customCell") //클래스 타입 자체를
    }
}



extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewTableViewCell
        
        cell.label.text = list[indexPath.row].text
       cell.label.numberOfLines =  list[indexPath.row].isExpand ? 0 : 2
        
//        cell.textLabel?.text = list[indexPath.row].text
//        cell.textLabel?.numberOfLines =  list[indexPath.row].isExpand ? 0 : 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        isExpand.toggle()
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic) //특정 cell들에 대해서만 reload함
    }
    
}
