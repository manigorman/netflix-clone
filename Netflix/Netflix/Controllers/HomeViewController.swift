//
//  HomeViewController.swift
//  Netflix
//
//  Created by Igor Manakov on 23.02.2022.
//

import UIKit
import CloudKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTVs = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        
        configureNavBar()
        configureHeaderView()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
    }
    
    private func setConstraints() {
        
    }
    
    private func setupDelegate() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    //MARK: - Configure Methods
    
    private func configureHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: TitleModel(titleName: selectedTitle?.original_title ?? selectedTitle?.original_name ?? "Unknown", posterURL: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil), UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        navigationController?.navigationBar.tintColor = .label
    }
    
}
