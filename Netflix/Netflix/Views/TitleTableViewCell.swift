//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Igor Manakov on 27.02.2022.
//

import UIKit

struct TitleModel {
    let titleName: String
    let posterURL: String
}

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setConstraints() {
        let titlePosterImageViewConstraints = [
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 90)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: 20)
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlePosterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)
        
    }
    
    public func configure(with model: TitleModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.titlePosterImageView.image = UIImage(data: data)
            }
        }
        titleLabel.text = model.titleName
    }
    
}
