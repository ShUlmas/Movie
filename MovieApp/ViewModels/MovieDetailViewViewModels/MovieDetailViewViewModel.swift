//
//  DetailViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 01/05/24.
//

import UIKit

class MovieDetailViewViewModel {
    enum SectionType {
        case movieDetails(viewModel: MovieDetailsCollectionViewCellViewModel)
        case topCasts(viewModels: [TopCastsCollectionViewCellViewModel])
        case similarMovies(viewModels: [SimilarMovieViewModel])
    }
    
    
    public var sections: [SectionType] = []
    private let dataFetcherService = DataFetcherService()
    
    private var movieDetails: MovieDetailsCollectionViewCellViewModel?
    private var movieCredits: [TopCastsCollectionViewCellViewModel] = []
    private var similarMovies: [SimilarMovieViewModel] = []
    
    
    var id: Int = 0

    private func setupSection() {
        
        guard let movieDetails = movieDetails else { return }
        
        sections = [
            .movieDetails(viewModel: movieDetails),
            .topCasts(viewModels: movieCredits),
            .similarMovies(viewModels: similarMovies),
        ]
    }
    
    
    func fetchMovieDetails(completion: @escaping() -> ()) {
        dataFetcherService.fetchMovieDetails(id: id) { details in
            guard let details = details else { return }
            self.movieDetails = MovieDetailsCollectionViewCellViewModel(movieDetails: details)
           
            self.setupSection()
            completion()
        }
        
        dataFetcherService.fetchMovieCredits(id: id) { credits in
            guard let credits = credits else { return }
            self.movieCredits = credits.cast.map { TopCastsCollectionViewCellViewModel(cast: $0) }
            self.setupSection()
            completion()
        }
        
        dataFetcherService.fetchSimilarMovies(id: id) { similarMovies in
            guard let similarMovies = similarMovies else { return }
            self.similarMovies = similarMovies.results.map { SimilarMovieViewModel(similarMovie: $0) }
            self.setupSection()
            completion()
        }
    }
    
    //MARK: - section layouts
    
    func movieDetailsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    func topCastsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(136), heightDimension: .absolute(164))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                  heightDimension: .absolute(50.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: headerSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        section.interGroupSpacing = 16
        return section
    }
    
    func similarMovieSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        
        section.interGroupSpacing = 16
        return section
    }
}
