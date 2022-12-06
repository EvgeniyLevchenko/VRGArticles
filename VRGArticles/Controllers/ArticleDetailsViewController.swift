//
//  ArticleDetailsViewController.swift
//  VRGArticles
//
//  Created by QwertY on 04.12.2022.
//

import UIKit


class ArticleDetailsViewController: UIViewController {
    
    private var viewModel: ArticleDetailsViewModelType
    
    private let articleImageView = UIImageView(contentMode: .scaleToFill, backgroundColor: .systemGray5, cornerRadius: 20)
    private let articleTitleLabel = UILabel(text: "Most Email Article For All The Time", font: .avenirMedium18(), textAlignment: .center, numberOfLines: 0)
    private let authorInfoView = InfoView(title: "Written", info: "By Yevhenii Levchenko")
    private let sectionInfoView = InfoView(title: "Section", info: "Science")
    private let summaryInfoView = InfoView(title: "Summary", info: "It’s never been harder to oversee America’s classrooms, and it’s driving educators out en masse.")
    private let publishedInfoView = InfoView(title: "Published", info: "20.11.2022")
    
    init(viewModel: ArticleDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.downloadImage { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                }
            }
        }
        articleTitleLabel.text = viewModel.articleTitle
        authorInfoView.infoLabel.text = viewModel.articleAuthor
        sectionInfoView.infoLabel.text = viewModel.articleSection
        summaryInfoView.infoLabel.text = viewModel.articleSummary
        publishedInfoView.infoLabel.text = viewModel.articlePublishedDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainWhite()
        setupConstraints()
        addBarButtonItem()
    }
    
    private func addBarButtonItem() {
        var image: UIImage?
        
        switch viewModel.isArticleSaved {
        case true:
            image = UIImage(systemName: "star.fill")
        case false:
            image = UIImage(systemName: "star")
        }
        
        let rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(favouritesButtonPressed))
        navigationItem.setRightBarButton(rightBarButtonItem, animated: false)
    }
    
    @objc private func favouritesButtonPressed() {
        switch viewModel.isArticleSaved {
        case true:
            viewModel.removeArticleFromFavourites { error in
                if let error = error {
                    self.showAlert(with: "Error!", message: error.localizedDescription)
                } else {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
                }
            }
        case false:
            viewModel.addArticleToFavourites { error in
                if let error = error {
                    self.showAlert(with: "Error!", message: error.localizedDescription)
                } else {
                    self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
                }
            }
        }
    }
}

// MARK: - Setup Layout
extension ArticleDetailsViewController {
    private func setupConstraints() {
        let aboutArticleStackView = UIStackView(arrangedSubviews: [
            authorInfoView,
            sectionInfoView,
            summaryInfoView,
            publishedInfoView
        ],
                                          axis: .vertical,
                                          spacing: 10)
        
        let mainStackView = UIStackView(arrangedSubviews: [
            articleImageView,
            articleTitleLabel,
            aboutArticleStackView
        ],
                                        axis: .vertical,
                                        spacing: 15)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            articleImageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: view.bounds.size.width * (2.0/3.0))
        ])
    }
}
