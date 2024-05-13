//
//  SplashViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 30/04/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    //MARK: - UI Components
    private var animatinoLogo: LottieAnimationView?
    
    //MARK: - Variables
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        animatinoLogo = .init(name: "NetflixSplashScreenAnimation")
        
        animatinoLogo!.frame = view.bounds
        animatinoLogo!.contentMode = .scaleAspectFit
        animatinoLogo!.loopMode = .playOnce
        animatinoLogo!.animationSpeed = 1
        view.addSubview(animatinoLogo!)
        animatinoLogo!.play()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration: 0.3) {
                self.animatinoLogo?.alpha = 0
            } completion: { done in
                if done {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        let tabbar = TabbarController()
                        tabbar.modalTransitionStyle = .crossDissolve
                        tabbar.modalPresentationStyle = .fullScreen
                        self.present(tabbar, animated: true)
                    }
                }
            }
        }
    }
}
