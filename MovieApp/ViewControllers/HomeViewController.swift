//
//  HomeViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - UI Components
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var collectionView: UICollectionView?
    
    //MARK: - Variables
    let viewModel = HomeViewViewModel()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureCollectionView()
        setupNavbar()
        setupConstraints()
        fetchData()
    }
    
    //MARK: - Functions
    private func addSubviews() {
        setBackground(imageStr: "bg")
        view.addBlurEffect(style: .systemChromeMaterialDark)
        view.addSubview(spinner)
    }
    
    /// fetch data
    private func fetchData() {
        spinner.startAnimating()
        viewModel.fetchMovies {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            self.spinner.stopAnimating()
            UIView.animate(withDuration: 0.5) {
                self.collectionView?.alpha = 1
            }
        }
    }
    /// Configure Collection View
    private func configureCollectionView() {
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        collectionView.alpha = 0
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    /// Setup navbar
    private func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "movie-logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        navigationItem.titleView = imageView
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(searchButtonTap))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
    }
    
    /// setup constraints
    private func setupConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 120),
            spinner.heightAnchor.constraint(equalToConstant: 120),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    /// Create collectionView composititonal layout
    private func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellID)
        collectionView.register(SectionTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTitleCollectionReusableView.identifier)
        
        return collectionView
    }
    
    /// Create section layout
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sections = viewModel.sections
        
        switch sections[sectionIndex] {
        case .trending:
            return viewModel.trendingMoviesSectionLayout()
        case .upcoming:
            return viewModel.upcomingMovieSectionsLayout()
        case .topRated:
            return viewModel.topRatedMoviesSectionsLayout()
        case .popular:
            return viewModel.popularMoviesSectionsLayout()

        }
    }
    
    //MARK: - Actions
    @objc func searchButtonTap() {
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .trending(viewModels: let viewModels):
            return viewModels.count
        case .upcoming(viewModels: let viewModels):
            return viewModels.count
        case .topRated(viewModels: let viewModels):
            return viewModels.count
        case .popular(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        
        case .trending(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            cell.configureCell(with: viewModel)
            
            return cell

        case .upcoming(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            cell.configureCell(with: viewModel)
            return cell

        case .topRated(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            cell.configureCell(with: viewModel)
            return cell

        case .popular(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            cell.configureCell(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleCollectionReusableView.identifier, for: indexPath) as! SectionTitleCollectionReusableView
            
            let section = viewModel.sections[indexPath.section]
            switch section {
            case .trending:
                header.configure(title: "Trending")
            case .upcoming:
                header.configure(title: "Upcoming", buttonHide: false)
                header.moreButtonAction = {
                    let vc = MoreMoviesViewController()
                    vc.viewModel.endpoint = Endpoints.upcomingMoviesEndpoint
                    vc.viewModel.viewTitleStr = "upcomingTitle"
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .topRated:
                header.configure(title: "Top rated", buttonHide: false)
                header.moreButtonAction = {
                    let vc = MoreMoviesViewController()
                    vc.viewModel.endpoint = Endpoints.topRatedMoviesEndpoint
                    vc.viewModel.viewTitleStr = "topRatedTitle"
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .popular:
                header.configure(title: "Popular", buttonHide: false)
                header.moreButtonAction = {
                    let vc = MoreMoviesViewController()
                    vc.viewModel.endpoint = Endpoints.popularMoviesEndpoint
                    vc.viewModel.viewTitleStr = "popularTitle"
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .trending:
            vc.viewModel.id = viewModel.trendingMoviesViewModels[indexPath.item].movie.id
        case .upcoming:
            vc.viewModel.id = viewModel.upcomingMoviesViewModels[indexPath.item].movie.id
        case .topRated:
            vc.viewModel.id = viewModel.topRatedMoviesViewModels[indexPath.item].movie.id
        case .popular:
            vc.viewModel.id = viewModel.popularMoviesViewModels[indexPath.item].movie.id

        }
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
