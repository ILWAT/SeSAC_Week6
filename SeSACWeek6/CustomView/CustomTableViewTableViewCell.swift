//
//  CustomTableViewTableViewCell.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/25.
//

import UIKit

class CustomTableViewTableViewCell: UITableViewCell {
    
    let label = UILabel()
    let button = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure() //addSubView와 같은 설정
        setConstraints() // addSubView이후에 constraints 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
//        addSubView(label) //오류가 안남... 하지만 오토레이아웃 설정은 잘 안됨.
        contentView.addSubview(label)
        contentView.addSubview(button)
        label.backgroundColor = .yellow
        button.backgroundColor = .green
    }
    
    func setConstraints() {
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView)
        }
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
        
    }
    
    //Interface Builder => awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
