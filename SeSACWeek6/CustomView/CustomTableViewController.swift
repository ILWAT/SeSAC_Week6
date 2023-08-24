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
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
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
        
        tableView.delegate = self
        tableView.dataSource = self
        //UINib -> Xib
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
    }
}



extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")!
        cell.textLabel?.text = list[indexPath.row].text
        cell.textLabel?.numberOfLines =  list[indexPath.row].isExpand ? 0 : 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        isExpand.toggle()
        list[indexPath.row].isExpand.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic) //특정 cell만 reload함
    }
    
}
