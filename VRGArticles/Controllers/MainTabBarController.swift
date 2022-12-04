//
//  MainTabBarController.swift
//  VRGArticles
//
//  Created by QwertY on 02.12.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var viewModel: MainTabBarViewModelType
    
    init(viewModel: MainTabBarViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor.systemGray4.cgColor
        tabBar.layer.borderWidth = 1
    }
    
    private func setupViewControllers() {
        viewControllers = viewModel.generateViewControllers()
    }
}
