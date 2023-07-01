//
//  RootTabBarVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 27/06/2023.
//

import UIKit

enum SFImage {
    case search
    case recents
    case favourites
    case bookmark
    case bookmarked
}

extension SFImage {
    var name : String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .recents:
            return "clock.arrow.circlepath"
        case .favourites:
            return "star.fill"
        case .bookmark:
            return "bookmark"
        case .bookmarked:
            return "bookmark.fill"
        }
    }
}

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
        let movieSearchVC = createNavBarVC(MovieSearchVC(), "Search", SFImage.search.name)
        let recentlySearchVC = createNavBarVC(RecentsSearchVC(), "Recents", SFImage.recents.name)
        let favouritesVC = createNavBarVC(FavouritesVC(), "Favourites", SFImage.favourites.name)
        
        viewControllers = [movieSearchVC, recentlySearchVC, favouritesVC]
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
}
