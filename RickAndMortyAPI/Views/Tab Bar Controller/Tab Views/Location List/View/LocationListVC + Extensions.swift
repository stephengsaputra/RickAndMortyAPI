//
//  LocationListVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 03/02/23.
//

import UIKit

extension LocationListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unsupported cell")
        }
        
        let vm = LocationTableViewCellVM(location: viewModel.locations[indexPath.row])
        cell.configure(with: vm)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let locationModel = viewModel.location(at: indexPath.row) else {
            print("ERROR")
            return
        }
        
        print(locationModel.url)
    }
}

extension LocationListVC: LocationListVCDelegate {
    
    func didLoadInitialLocations() {
        spinner.stopAnimating()
        tableView.reloadData()
        tableView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 1
        }
    }
    
    func didLoadMoreLocations(with newIndexPath: [IndexPath]) {
        
    }
}
