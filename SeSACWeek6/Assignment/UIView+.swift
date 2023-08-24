//
//  UIView+.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit

extension UIView{
    
    func addSubViews(_ views: [UIView]){
        for item in views{
            self.addSubview(item)
        }
    }
}

