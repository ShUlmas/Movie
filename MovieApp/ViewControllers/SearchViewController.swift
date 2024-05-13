//
//  SearchViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 29/04/24.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - UI Components
    
    private lazy var searchTextField = SearchTextField()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 16
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK: - Variables
    
    private let viewModel = SearchViewViewModel()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNavbar()
        setupConstraints()
        configureCollectionView()
        fetchSearchResults()
        
        searchTextField.delegate = self
    }
    
    //MARK: - Functions
    
    private func fetchSearchResults() {
        viewModel.getSearchedMovies(text: searchTextField.text!) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func addSubviews() {
        setBackground(imageStr: "bg")
        view.addBlurEffect(style: .systemChromeMaterialDark)
        
        view.addSubview(searchTextField)
        view.addSubview(collectionView)
    }
    
    private func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "searchTitle"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        navigationItem.titleView = imageView
        
        let backButton = UIBarButtonItem(image: UIImage(named: "left"), style: .done, target: self, action: #selector(backButtonTap))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellID)
        collectionView.alpha = 0
    }
    
    //MARK: - Actions
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTap() {
        fetchSearchResults()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellID, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureSearchedMovie(with: viewModel.searchResults[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.frame.width - 12) / 2,
            height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.id = viewModel.searchResults[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {

        fetchSearchResults()
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1
        }
    }
    
    // keyboarddagi return button bosilganda keyboard yopilishi
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // textfield bosilganda keyboard chiqishi
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}
