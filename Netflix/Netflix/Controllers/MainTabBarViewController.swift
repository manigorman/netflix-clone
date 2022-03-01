//
//  ViewController.swift
//  Netflix
//
//  Created by Igor Manakov on 23.02.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTabBar()
        
        let homeVC = setupNavigationController(for: HomeViewController(), image: UIImage(systemName: "house"), selectedImage:  UIImage(systemName: "house.fill"), title: "Home")
        let upcomingVC = setupNavigationController(for: UpcomingViewController(), image: UIImage(systemName: "play"), selectedImage:  UIImage(systemName: "play.fill"), title: "Coming soon")
        let searchVC = setupNavigationController(for: SearchViewController(), image: UIImage(systemName: "magnifyingglass"), selectedImage:  UIImage(systemName: "magnifyingglass"), title: "Top Search")
        let downloadsVC = setupNavigationController(for: DownloadsViewController(), image: UIImage(systemName: "arrow.down.to.line"), selectedImage:  UIImage(systemName: "arrow.down.to.line"), title: "Downloads")
        
        setViewControllers([homeVC, upcomingVC, searchVC, downloadsVC], animated: false)
    }

    //MARK: - Setup
    
    private func setupTabBar() {
        tabBar.tintColor = .label
    }
    
    private func setupNavigationController(for rootViewController: UIViewController, image: UIImage?, selectedImage: UIImage?, title: String) -> UINavigationController {
        let vc = UINavigationController(rootViewController: rootViewController)
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        vc.title = title
        
        return vc
    }

}
