//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Igor Manakov on 23.02.2022.
//

import UIKit

class UpcomingViewController: UIViewController {

    var titles: [Title] = []
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return table
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        upcomingTable.frame = view.bounds
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
    }
    
    private func setConstraints() {
        
    }
    
    private func setupDelegate() {
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    }
    
    //MARK: - Fetch Method
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
