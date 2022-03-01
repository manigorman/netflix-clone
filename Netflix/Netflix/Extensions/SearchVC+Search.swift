//
//  SearchVC+Search.swift
//  Netflix
//
//  Created by Igor Manakov on 02.03.2022.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
//              query.trimmingCharacters(in: .whitespaces).isEmpty,
//              query.trimmingCharacters(in: .whitespaces).count >= 3,
            let resultsController = searchController.searchResultsController as? SearchResultsViewController else {return}
        resultsController.delegate = self
        APICaller.shared.search(with: query) { result in
            switch result {
            case .success(let titles):
                resultsController.titles = titles
                DispatchQueue.main.async {
                    resultsController.searchResultsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

