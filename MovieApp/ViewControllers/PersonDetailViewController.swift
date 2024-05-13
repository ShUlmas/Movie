//
//  PersonDetailViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 02/05/24.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    //MARK: - UI Components
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var collectionView: UICollectionView?
    //MARK: - Variables
    
    var viewModel = PersonDetailViewViewModel()
    
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
        viewModel.fetchPersonDetails {
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
        let imageView = UIImageView(image: UIImage(named: "personDetailsTitle"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 210).isActive = true
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

        collectionView.register(PersonDetailCollectionViewCell.self, forCellWithReuseIdentifier: PersonDetailCollectionViewCell.cellID)
        collectionView.register(PersonDetailAddsCollectionViewCell.self, forCellWithReuseIdentifier: PersonDetailAddsCollectionViewCell.cellID)
        collectionView.register(BiographyCollectionViewCell.self, forCellWithReuseIdentifier: BiographyCollectionViewCell.cellID)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellID)

        collectionView.register(SectionTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTitleCollectionReusableView.identifier)
        
        return collectionView
    }
    
    /// Create section layout
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sections = viewModel.sections
        
        switch sections[sectionIndex] {
        case .personDetails:
            return viewModel.personDetailsSectionLayout()
        case .adds:
            return viewModel.personDetailAddsSectionLayout()
        case .personBiography:
            return viewModel.personBiographySectionLayout()
        case .personMovieCredits:
            return viewModel.moviesSection()
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
extension PersonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .personDetails:
            return 1
        case .adds(viewModels: let viewModels):
            return viewModels.count
        case .personBiography:
            return 1
        case .personMovieCredits(viewModels: let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
            
        case .personDetails(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonDetailCollectionViewCell.cellID, for: indexPath) as? PersonDetailCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(with: viewModel)
            return cell
        case .adds(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonDetailAddsCollectionViewCell.cellID, for: indexPath) as? PersonDetailAddsCollectionViewCell else { return UICollectionViewCell() }
            
            let viewModel = viewModels[indexPath.item]
            
            cell.configureCell(with: viewModel)
            
            return cell
        case .personBiography(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BiographyCollectionViewCell.cellID, for: indexPath) as? BiographyCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModel
            
            cell.configureCell(with: viewModel)
            
            return cell
        case .personMovieCredits(viewModels: let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.item]
            
            cell.configurePersonMovieCreditCell(with: viewModel)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleCollectionReusableView.identifier, for: indexPath) as! SectionTitleCollectionReusableView
            
            let section = viewModel.sections[indexPath.section]
            switch section {
            case .personDetails:
                header.configure(title: "Movie detail")
            case .adds:
                header.configure(title: "Adds detail")
            case .personBiography:
                header.configure(title: "Biography")
            case .personMovieCredits:
                header.configure(title: "Acted movies")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.id = viewModel.personMovieCredits[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
}
