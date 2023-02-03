//
//  LocationTableViewCellVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/02/23.
//

import Foundation

final class LocationTableViewCellVM: Hashable, Equatable {
    
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    public var name: String {
        return location.name ?? ""
    }
    
    public var type: String {
        return location.type ?? ""
    }
    
    public var dimension: String {
        return location.dimension ?? ""
    }
    
    // MARK: - Hashable
    static func == (lhs: LocationTableViewCellVM, rhs: LocationTableViewCellVM) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(name)
        hasher.combine(type)
        hasher.combine(dimension)
        hasher.combine(location.id)
    }
}
