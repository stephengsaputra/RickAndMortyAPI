//
//  LocationListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/01/23.
//

import Foundation

final class LocationListVM {
    
    weak var delegate: LocationListVCDelegate?
    
    var locations: [Location] = []
    var apiInfo: Info? = nil
    
    var isLoadingMoreLocations = false
    
    /// Fetch initial set of locations
    func fetchLocations() {
        
        APIService.shared.execute(.getLocationsListRequest, expecting: LocationsResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.locations.append(contentsOf: model.results ?? [])
                    let info = model.info
                    self?.apiInfo = info
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialLocations()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    public func location(at index: Int) -> Location? {
        
        return self.locations[index]
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
