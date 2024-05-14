//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/05/24.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorColor = UIColor(hex: "FFB703")
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel = FavouriteMoviesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavouriteMovies()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNavbar()
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.cellId)
    }
    
    private func addSubviews() {
        setBackground(imageStr: "bg")
        view.addBlurEffect(style: .systemChromeMaterialDark)
        view.addSubview(tableView)
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favouriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.cellId, for: indexPath) as? FavouritesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: viewModel.favouriteMoviesCollectionViewCellViewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.id = viewModel.favouriteMovies[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


// Ol bn oylq
