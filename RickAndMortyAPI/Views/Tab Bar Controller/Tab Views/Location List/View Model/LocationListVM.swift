//
//  LocationListVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/01/23.
//

import Foundation

final class LocationListVM {
    
    var locations: [Location] = []
    var apiInfo: Info? = nil
    
    /// Fetch initial set of locations
    func fetchLocations() {
        
        APIService.shared.execute(.getLocationsListRequest, expecting: LocationsResponse.self) { [weak self] result in
            switch result {
                case .success(let model):
                
                    self?.locations.append(contentsOf: model.results ?? [])
                    print(String(describing: self?.locations))
                    
                    let info = model.info
                    self?.apiInfo = info
                case .failure(let error):
                    print(error)
            }
        }
    }
}
