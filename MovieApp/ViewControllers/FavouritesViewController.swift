//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/05/24.
//

import UIKit

class FavouritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNavbar()
    }
    
    private func addSubviews() {
        setBackground(imageStr: "bg")
        view.addBlurEffect(style: .systemChromeMaterialDark)
        
    }
    
    private func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "favouritesTitle"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        DispatchQueue.main.async {
            self.navigationItem.titleView = imageView
        }
    }
}
