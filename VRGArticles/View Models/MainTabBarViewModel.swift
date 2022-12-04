//
//  MainTabBarViewModel.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import UIKit

class MainTabBarViewModel: MainTabBarViewModelType {
    
    private let viewedArticlesViewController: ViewedArticlesViewController
    private let sharedArticlesViewController: SharedArticlesViewController
    private let emailedArticlesViewController: EmailedArticlesViewController
    private let favouritesViewController: FavouritesViewController
    
    init() {
        let viewedViewModel = MostViewedArticlesViewModel()
        let sharedViewModel = MostSharedArticlesViewModel()
        let emailedViewModel = MostEmailedArticlesViewModel()
        let favouritesViewModel = FavouriteArticlesViewModel()
        viewedArticlesViewController = ViewedArticlesViewController(viewModel: viewedViewModel)
        sharedArticlesViewController = SharedArticlesViewController(viewModel: sharedViewModel)
        emailedArticlesViewController = EmailedArticlesViewController(viewModel: emailedViewModel)
        favouritesViewController = FavouritesViewController(viewModel: favouritesViewModel)
    }
    
    private func generateViewController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
    func generateViewControllers() -> [UIViewController] {
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        guard let mostViewedImage = UIImage(systemName: "book", withConfiguration: boldConfig),
              let mostShared = UIImage(systemName: "shared.with.you", withConfiguration: boldConfig),
              let mostEmailed = UIImage(systemName: "envelope", withConfiguration: boldConfig),
              let favouritesImage = UIImage(systemName: "star", withConfiguration: boldConfig)
        else {
            fatalError("Cannot find images to setup view")
        }
        
        let viewControllers = [
            generateViewController(rootViewController: viewedArticlesViewController, title: "Most Viewed", image: mostViewedImage),
            generateViewController(rootViewController: sharedArticlesViewController, title: "Most Shared", image: mostShared),
            generateViewController(rootViewController: emailedArticlesViewController, title: "Most Emailed", image: mostEmailed),
            generateViewController(rootViewController: favouritesViewController, title: "Favourites", image: favouritesImage)
        ]
        
        return viewControllers
    }
}
