//
//  PeoplesViewController.swift
//  MovieApp
//
//  Created by O'lmasbek on 11/05/24.
//

import UIKit

class PersonsViewController: UIViewController {

    //MARK: - UI Components
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 16
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    //MARK: - Variables
    
    let viewModel = PersonsViewViewModel()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNavbar()
        setupConstraints()
        configureCollectionView()
        fetchData()
        
        collectionView.register(FooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
    }
    
    //MARK: - Functions
    
    private func fetchData() {
        spinner.startAnimating()
        viewModel.fetchPersons {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
                self.spinner.stopAnimating()
                
            }
        }
    }

    private func addSubviews() {
        setBackground(imageStr: "bg")
        view.addBlurEffect(style: .systemChromeMaterialDark)
        
        view.addSubview(collectionView)
    }
    
    private func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "personsTitle"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        navigationItem.titleView = imageView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.cellID)
        collectionView.alpha = 0
    }
    
    //MARK: - Actions
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension PersonsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.cellID, for: indexPath) as? PersonCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configurePersonCell(with: viewModel.persons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.frame.width - 12) / 2,
            height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PersonDetailViewController()
        vc.viewModel.id = viewModel.persons[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? FooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if viewModel.isPageRefreshing {
            return CGSize(
                width: collectionView.frame.width,
                height: 100)
        } else {
            return .zero
        }
    }
}

//MARK: - UIScrollViewDelegate

extension PersonsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                if self?.viewModel.isPageRefreshing == true {
                    self?.viewModel.page += 1
                    self?.viewModel.isPageRefreshing = false
                    self?.viewModel.fetchPersons {
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                            self?.viewModel.isPageRefreshing = true
                        }
                    }
                }
            }
            t.invalidate()
        }
    }
}
