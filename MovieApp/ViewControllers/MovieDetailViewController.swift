//
//  DetailViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    //MARK: - UI Components
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var collectionView: UICollectionView?
    //MARK: - Variables
    
    var viewModel = MovieDetailViewViewModel()
    
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
        viewModel.fetchMovieDetails {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            UIView.animate(withDuration: 0.5) {
                self.spinner.stopAnimating()
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
        let imageView = UIImageView(image: UIImage(named: "movieDetailsTitle"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        navigationItem.titleView = imageView
        
        let backButton = UIBarButtonItem(image: UIImage(named: "left"), style: .done, target: self, action: #selector(backButtonTap))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "heart"), style: .done, target: self, action: #selector(heartButtonTap))
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
        collectionView.register(MovieDetailsCollectionViewCell.self, forCellWithReuseIdentifier: MovieDetailsCollectionViewCell.cellID)
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.cellID)

        
        collectionView.register(SectionTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTitleCollectionReusableView.identifier)
        
        return collectionView
    }
    
    /// Create section layout
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sections = viewModel.sections
        
        switch sections[sectionIndex] {
        case .movieDetails:
            return viewModel.movieDetailsSectionLayout()
        case .topCasts:
            return viewModel.topCastsSectionLayout()
        case .similarMovies:
            return viewModel.similarMovieSectionLayout()
        }
    }
    //MARK: - Actions
    
    @objc func heartButtonTap() {
        navigationController?.navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .movieDetails:
            return 1
        case .topCasts(viewModels: let viewModels):
            return viewModels.count
        case .similarMovies(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        
        case .movieDetails(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailsCollectionViewCell.cellID, for: indexPath) as? MovieDetailsCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(with: viewModel)
            return cell

        case .topCasts(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.cellID, for: indexPath) as? PersonCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            
            cell.configureCell(with: viewModel)
            
            return cell

        case .similarMovies(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            
            cell.configureSimilarMovieCell(with: viewModel)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleCollectionReusableView.identifier, for: indexPath) as! SectionTitleCollectionReusableView
            
            let section = viewModel.sections[indexPath.section]
            switch section {
            case .movieDetails:
                header.configure(title: "Movie detail")
            case .topCasts:
                header.configure(title: "Top Casts")
            case .similarMovies:
                header.configure(title: "Similar Movies")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = viewModel.sections[indexPath.section]
        switch section {
            
        case .movieDetails:
            break
        case .topCasts(let viewModels):
            let vc = PersonDetailViewController()
            vc.viewModel.id = viewModels[indexPath.item].id
            navigationController?.pushViewController(vc, animated: true)
        case .similarMovies(viewModels: let viewModels):
            viewModel.id = viewModels[indexPath.item].id
            collectionView.alpha = 0
            spinner.startAnimating()
            viewModel.fetchMovieDetails {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                UIView.animate(withDuration: 0.5) {
                    collectionView.alpha = 1
                }
                self.spinner.stopAnimating()
            }
        }
    }
}
