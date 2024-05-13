//
//  TabbarController.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/05/24.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: HomeViewController()),
                title: "Movies",
                image: UIImage(systemName: "movieclapper.fill")
            ),
            generateVC(
                viewController: UINavigationController(rootViewController: FavouritesViewController()),
                title: "Favourites",
                image: UIImage(systemName: "heart.fill")
            ),
            generateVC(
                viewController: UINavigationController(rootViewController: PersonsViewController()),
                title: "Persons",
                image: UIImage(systemName: "person.3.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        
        
        // UIBlurEffectView yaratish
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.addSubview(blurEffectView)
        tabBar.sendSubviewToBack(blurEffectView) // UIBlurEffectView ni orqaga o'qitish

        
        tabBar.itemPositioning = .centered
        
       //roundLayer.fillColor = #colorLiteral(red: 0.2891496122, green: 0.220874697, blue: 0.2652337849, alpha: 1).cgColor
        
        
        tabBar.tintColor = UIColor(hex: "FFB703")
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9960784314, green: 0.9176470588, blue: 0.9803921569, alpha: 0.5)
    }
}
