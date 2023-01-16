//
//  EpisodeListVC + Extensions.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 15/01/23.
//

import UIKit

extension EpisodeListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let vm = EpisodeCollectionViewCellVM(
            episodeName: self.viewModel.episodes[indexPath.row].name ?? "",
            episodeSeasion: self.viewModel.episodes[indexPath.row].episode ?? "",
            episodeAirDate: self.viewModel.episodes[indexPath.row].airDate ?? ""
        )
        cell.configure(with: vm)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 20)

        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selection = viewModel.episodes[indexPath.row]
        
        let vc = EpisodeDetailVC(url: URL(string: selection.url ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingFooterCollectionReusableView.identifier, for: indexPath) as? LoadingFooterCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard viewModel.shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard viewModel.shouldShowLoadMoreIndicator, !viewModel.isLoadingMoreEpisodes, let nextURLString = viewModel.apiInfo?.next, let url = URL(string: nextURLString) else { return }
        
        let lastElement = viewModel.episodes.count - 1
        
        if indexPath.row == lastElement {
            viewModel.fetchMoreEpisodes(url: url)
        }
    }
}

extension EpisodeListVC: EpisodeListVCDelegate {
    
    func didLoadInitialEpisodes() {
        
        spinner.stopAnimating()
        collectionView.reloadData()
        
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath]) {
        
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
}
