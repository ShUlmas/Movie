//
//  HomeViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import UIKit

class HomeViewViewModel {
    enum SectionType {
        case trending(viewModels: [MovieCollectionViewCellViewModel])
        case upcoming(viewModels: [MovieCollectionViewCellViewModel])
        case topRated(viewModels: [MovieCollectionViewCellViewModel])
        case popular(viewModels: [MovieCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    private let dataFetcherService = DataFetcherService()
    
    
    public var trendingMoviesViewModels: [MovieCollectionViewCellViewModel] = []
    public var upcomingMoviesViewModels: [MovieCollectionViewCellViewModel] = []
    public var topRatedMoviesViewModels: [MovieCollectionViewCellViewModel] = []
    public var popularMoviesViewModels: [MovieCollectionViewCellViewModel] = []

    
    private var movies: [Movie] = []
    
    
    private func setupSection() {
        sections = [
            .trending(viewModels: trendingMoviesViewModels),
            .upcoming(viewModels: upcomingMoviesViewModels),
            .topRated(viewModels: topRatedMoviesViewModels),
            .popular(viewModels: popularMoviesViewModels),
        ]
    }
    
    
    func fetchMovies(completion: @escaping() -> ()) {
        dataFetcherService.fetchMovies(endpoint: .trendingMoviesEndpoint) { movies in
            guard let movies = movies else { return }
            self.movies = movies.results
            self.trendingMoviesViewModels = movies.results.map { MovieCollectionViewCellViewModel(movie: $0) }
            self.setupSection()
            completion()
        }
        
        dataFetcherService.fetchMovies(endpoint: .upcomingMoviesEndpoint) { movies in
            guard let movies = movies else { return }
            self.movies = movies.results
            self.upcomingMoviesViewModels = movies.results.map { MovieCollectionViewCellViewModel(movie: $0) }
            self.setupSection()
            completion()
        }
        
        dataFetcherService.fetchMovies(endpoint: .topRatedMoviesEndpoint) { movies in
            guard let movies = movies else { return }
            self.movies = movies.results
            self.topRatedMoviesViewModels = movies.results.map { MovieCollectionViewCellViewModel(movie: $0) }
            self.setupSection()
            completion()
        }
        
        dataFetcherService.fetchMovies(endpoint: .popularMoviesEndpoint) { movies in
            guard let movies = movies else { return }
            self.movies = movies.results
            self.popularMoviesViewModels = movies.results.map { MovieCollectionViewCellViewModel(movie: $0) }
            self.setupSection()
            completion()
        }
        completion()
    }
    
    //MARK: - section layouts
    
    func trendingMoviesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(420))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    func upcomingMovieSectionsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        if !upcomingMoviesViewModels.isEmpty {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        
        section.interGroupSpacing = 16
        return section
    }
    
    func topRatedMoviesSectionsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        if !topRatedMoviesViewModels.isEmpty {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        section.interGroupSpacing = 16
        return section
    }
    
    func popularMoviesSectionsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        if !popularMoviesViewModels.isEmpty {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        section.interGroupSpacing = 16
        return section
    }
}
