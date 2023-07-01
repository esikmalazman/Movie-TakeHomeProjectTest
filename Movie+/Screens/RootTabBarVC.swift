//
//  RootTabBarVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

final class RootTabBarVC : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViewControllers()
    }
}

private extension RootTabBarVC {
    func createNavBarVC(_ viewController : UIViewController, _ title : String, _ image : String) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.title = title
        navigationController.tabBarItem.image = UIImage(systemName: image)
        
        return navigationController
    }
    
    func setupTabViewControllers() {
        let movieSearchVC = createNavBarVC(MovieSearchVC(), "Search", "magnifyingglass")
        let recentlySearchVC = createNavBarVC(RecentsSearchVC(), "Recents", "clock.arrow.circlepath")
        let favouritesVC = createNavBarVC(FavouritesVC(), "Favourites", "star.fill")
        
        viewControllers = [movieSearchVC, recentlySearchVC, favouritesVC]
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}
