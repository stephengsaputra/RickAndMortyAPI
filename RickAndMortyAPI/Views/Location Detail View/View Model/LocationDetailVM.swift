//
//  LocationDetailVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import Foundation

final class LocationDetailVM {
    
    private let endpointURL: URL?
    public weak var delegate: LocationDetailVCDelegate?
    
    private var dataTuple: (location: Location, characters: [Character])? {
        didSet {
            self.createCellViewModels()
            self.delegate?.didFetchLocationDetail()
        }
    }
    
    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellVM])
        case characters(viewModels: [CharacterCollectionViewCellVM])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Initializer
    init(endpointURL: URL?) {
        self.endpointURL = endpointURL
    }
    
    // MARK: - Functions
    func fetchLocationData() {
        
        guard let url = endpointURL, let request = APIRequest(url: url) else {
            return
        }
        
        APIService.shared.execute(request, expecting: Location.self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(location: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacter(location: Location) {
        
        let requests: [APIRequest] = (location.residents?.compactMap({ character in
            return URL(string: character)
        }).compactMap({ character in
            return APIRequest(url: character)
        })) ?? []
        
        let group = DispatchGroup()
        var characters: [Character] = []
        
        for request in requests {
            
            defer {
                group.leave()
            }
            
            group.enter()
            
            APIService.shared.execute(request, expecting: Character.self) { result in
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (location: location, characters: characters)
        }
    }
    
    private func createCellViewModels() {
        
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        
        var createdString = ""
        
        if let createdDate = CharacterDetailInformationVM.dateFormatter.date(from: location.created ?? "") {
            createdString = CharacterDetailInformationVM.shortDateFormatter.string(from: createdDate)
        }
        
        cellViewModels.append(
            .information(viewModels: [
                .init(title: "Location Name", value: location.name ?? ""),
                .init(title: "Type", value: location.type ?? ""),
                .init(title: "Dimension", value: location.dimension ?? ""),
                .init(title: "Created", value: createdString ?? "")
            ])
        )
        
        let characters = dataTuple.characters
        cellViewModels.append(
            .characters(viewModels: characters.compactMap({ character in
                return CharacterCollectionViewCellVM(
                    characterName: character.name ?? "",
                    characterStatus: character.status ?? .unknown,
                    characterImageURL: URL(string: character.image ?? "")
                )
            }))
        )
    }
    
    func character(at index: Int) -> Character? {
        
        guard let dataTuple = dataTuple else {
            return nil
        }
        
        return dataTuple.characters[index]
    }
}

