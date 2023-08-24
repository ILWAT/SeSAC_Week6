//
//  TheaterType.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import Foundation

enum TheaterType: String, CaseIterable{
    case lotte = "롯데시네마"
    case megaBox = "메가박스"
    case cgv = "CGV"
    case allType = "전체 보기"
    
    var getConstraintValue: String? {
        get{
            switch self {
            case .lotte, .megaBox, .cgv:
                return self.rawValue
            case .allType:
                return nil
            }
        }
    }
}
