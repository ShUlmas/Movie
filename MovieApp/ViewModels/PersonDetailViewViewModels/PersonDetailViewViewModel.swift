//
//  PersonDetailViewViewModel.swift
//  MovieApp
//
//  Created by O'lmasbek on 02/05/24.
//

import UIKit

class PersonDetailViewViewModel {
    
    enum SectionType {
        case personDetails(viewModel: PersonDetailCollectionViewCellViewModel)
        case personBiography(viewModel: PersonBiographyCollectionViewCellViewModel)
        case adds(viewModels: [PersonDetailAddsCollectionViewCellViewModel])
        case personMovieCredits(viewModels: [PersonMovieCreditCollectionViewViewModel])
    }
    
    public var sections: [SectionType] = []
    private let dataFetcherService = DataFetcherService()
    
    private var personDetails: PersonDetailCollectionViewCellViewModel?
    var personMovieCredits: [PersonMovieCreditCollectionViewViewModel] = []
    
    private var biography: String?
    private var gender: Int?
    private var birthday: String?
    private var knownFor: String?
    private var popularity: Double?
    
    /// Init
    var id: Int = 0
    
    private func setupSection() {
        
        guard let personDetails = personDetails else { return }
        
        sections = [
            .personDetails(viewModel: personDetails),
            .adds(viewModels: [
                .init(type: .gender, info: gender == 1 ? "Female" : "Male"),
                .init(type: .birthday, info: birthday ?? "Cannot find"),
                .init(type: .knownFor, info: knownFor ?? "Cannot find"),
                .init(type: .popularity, info: "\(Int(popularity ?? 0)) %")
            ]),
            .personBiography(viewModel: PersonBiographyCollectionViewCellViewModel(personBiography: biography ?? "Cannot find biography info")),
            .personMovieCredits(viewModels: personMovieCredits),
        ]
    }
    
    func fetchPersonDetails(completion: @escaping() -> ()) {
        dataFetcherService.fetchPersonDetails(id: id) { details in
            guard let details = details else { return }
            self.personDetails = PersonDetailCollectionViewCellViewModel(personDetails: details)
            
            self.biography = details.biography
            self.gender = details.gender
            self.birthday = details.birthday
            self.knownFor = details.knownForDepartment
            self.popularity = details.popularity
            
            self.setupSection()

            completion()
        }
        
        dataFetcherService.fetchPersonMovieCredits(id: id) { personMovieArray in
            guard let personMovieArray = personMovieArray else { return }
            self.personMovieCredits = personMovieArray.cast.map { PersonMovieCreditCollectionViewViewModel(personMovie: $0) }
            self.setupSection()
            completion()
        }
    }
    
    //MARK: - section layouts
    
    func personDetailsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(344))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func personDetailAddsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width - 56) / 4), heightDimension: .absolute(40))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 8
        
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func personBiographySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)

        return section
    }
    
    func moviesSection() -> NSCollectionLayoutSection {
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
