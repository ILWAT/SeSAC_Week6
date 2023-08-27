//
//  OnboardingViewController.swift
//  SeSACWeek6
//
//  Created by 문정호 on 2023/08/25.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
    }
}

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //1.
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .pageCurl   , navigationOrientation: .horizontal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true) //보여줄 viewController를 화면에 띄워줌
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = currentIndex - 1
        
        return previousIndex  < 0 ? nil : list[previousIndex] //이전 인덱스가 0보다 작다면(=현재 화면이 첫 화면이라면) nil을 반환하고 그게 아니라면 이전 viewController를 반환한다.
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex] //다음 인덱스가 총 페이지 수를 넘어가게 되면 nil을 반환하고 그게 아니라면 다음 viewController를 반환한다.
    }
    
    
    //Data source
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first , let index = list.firstIndex(of: first) else { return 0 } //현재 화면에 띄우고 있는 viewcontroller를 반환 -> index 구하기
        
        return index
    }
}










