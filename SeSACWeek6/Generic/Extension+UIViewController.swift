//
//  Extension+UIViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle{
        case present  //네비게이션 없이 present
        case presentNavigation //네비에이션 임베드 된 present
        case presentFullNavigation //네비게이션 임베드 된 fullScreen
        case push
    }
    
    /*
     String > String Type
     String.self > String.Type
     */
    // 만약 파라미터의 타입을 T로 해놓으면 UIViewController 인스턴스를 파라미터로 담아 전달하는 것인데 현재 메서드에서 필요한 파라미터는 인스턴스의 타입이 필요하다. 그렇기 때문에 파라미터 타입을 T.Type으로 설정해야한다.
    func transition<T: UIViewController>(viewController: T.Type, storyboard: String, style: TransitionStyle) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else {return}
        
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    //Type Parameter(T): 타입의 종류는 알려주지 않지만, 모두 같은 타입이 들어갈 것을 암시. 플레이스 홀더와 같은 역할
    //Type Constraints: 클래스 제약, 프로토콜 제약
    //UpperCased(U)
    func configureBorder<T: UIView>(view: T){
        view.layer.cornerRadius = 19
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
    }
    
    //Generic: 타입에 유연하게 대응하기 위한 요소
    //코드 중복과 재사용에 대응하기가 좋아서 추상적인 표현 가능
    func sum<SeSAC: AdditiveArithmetic>(a: SeSAC, b: SeSAC) -> SeSAC {
        return a + b
    }
    
    func sumInt(a: Int, b: Int) -> Int {
        return  a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return  a + b
    }
    
    func sumFloat(a: Float, b: Float) -> Float {
        return  a + b
    }
}
