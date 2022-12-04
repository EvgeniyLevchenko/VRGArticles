//
//  ArticleCollectionViewCell.swift
//  VRGArticles
//
//  Created by QwertY on 03.12.2022.
//

import UIKit
import SDWebImage

class ArticleCollectionViewCell: UICollectionViewCell, Configuring {
    
    static var reuseID: String = "ArticleCell"
    
    private var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray2
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = UIImage(named: "imagePlaceholder")
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Article title"
        label.font = .avenir20()
        return label
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Article author"
        label.font = .avenir20()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let article: Article = value as? Article else { return }
        if let strURL = article.media.first?.mediaMetadata.first?.url,
           let url = URL(string: strURL) {
            coverImageView.sd_setImage(with: url)
        }
        print()
        titleLabel.text = article.title
        authorLabel.text = article.byline
    }
}

// MARK: - Setup Constraints
extension ArticleCollectionViewCell {
    private func setupConstraints() {
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coverImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coverImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            coverImageView.widthAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            authorLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}
