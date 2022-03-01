//
//  SearchViewController.swift
//  Netflix
//
//  Created by Igor Manakov on 23.02.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    public var titles: [Title] = []
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.topItem?.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        view.addSubview(discoverTable)
    }
    
    private func setConstraints() {
        
    }
    
    private func setupDelegate() {
        discoverTable.delegate = self
        discoverTable.dataSource = self
    }
    
    //MARK: - Fetch Method
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
