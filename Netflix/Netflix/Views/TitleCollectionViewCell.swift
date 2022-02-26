//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Igor Manakov on 26.02.2022.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: model) else {return}
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }
    }
    
}
