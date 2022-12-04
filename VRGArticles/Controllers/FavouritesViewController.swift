//
//  FavouritesViewController.swift
//  VRGArticles
//
//  Created by QwertY on 02.12.2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<ArticleType, Article>?
    private var viewModel: ArticlesViewModelType
    
    init(viewModel: ArticlesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Favourite Articles"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupView()
    }
    
    private func setupView() {
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        bindView()
        fetchArticles()
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseID)
    }
    
    private func bindView() {
        viewModel.articles.bind {
            self.viewModel.reloadDataSource(with: nil) { snapshot in
                self.dataSource?.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    private func fetchArticles() {
        viewModel.fetchArticles { error in
            if let error = error {
                self.showAlert(with: "Error!", message: error.localizedDescription)
            }
        }
    }
}

// MARK: - Data Source
extension FavouritesViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ArticleType, Article>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, article) -> UICollectionViewCell? in
                self.configure(collectionView: self.collectionView, cellType: ArticleCollectionViewCell.self, with: article, for: indexPath)
            }
        )
    }
}

// MARK: - Setup Layout
extension FavouritesViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            self.createMostViewedArticlesSection()
        }
        return layout
    }
    
    private func createMostViewedArticlesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}

// MARK: - Search Bar Delegate
extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.reloadDataSource(with: searchText) { snapshot in
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                self.collectionView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reloadDataSource(with: nil) { snapshot in
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                self.collectionView.reloadData()
            })
        }
    }
}
