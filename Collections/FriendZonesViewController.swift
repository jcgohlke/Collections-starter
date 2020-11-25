//
//  FriendZonesViewController.swift
//  Collections
//
//  Created by Joben Gohlke on 9/14/20.
//  Copyright © 2020 Ben Gohlke. All rights reserved.
//

import UIKit

class FriendZonesViewController: UIViewController {
    //MARK: - Types -
    enum Section: CaseIterable {
        case main
    }
    
    enum LayoutMode: String {
        case grid
        case list
    }
    
    
    //MARK: - Properties -
    var dataSource: UICollectionViewDiffableDataSource<Section, String>? = nil
    var collectionView: UICollectionView! = nil
    var layoutMode: LayoutMode = .grid
    private var zones: [String] = ["Ayanna Kosoko",
                                   "Fernando Olivares",
                                   "Spencer Curtis",
                                   "Ben Gohlke",
                                   "Dimitri Bouniol",
                                   "Johnny Hicks",
                                   "Paul Solt"]
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Friend Zone"
        
        configureCollectionView()
        configureDataSource()
        configureNavbar()
    }
    
    
    //MARK: - Configuration Methods -
    private func configureNavbar() {
        let gridImage = UIImage(systemName: "square.grid.2x2")!
        let listImage = UIImage(systemName: "rectangle.grid.1x2")!
        
        let segmentedControl = UISegmentedControl(items: [gridImage, listImage])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changeCellStyle(_:)), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: segmentedControl)
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    // MARK: - Actions
    @objc private func changeCellStyle(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            layoutMode = .grid
        default:
            layoutMode = .list
        }
        collectionView.collectionViewLayout = createLayout()
    }
}



//MARK: - Extensions -
//MARK: - Collection View Diffable Data Source Methods -
extension FriendZonesViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(FriendCell.self,
                                forCellWithReuseIdentifier: FriendCell.reuseIdentifier)
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { collectionView, indexPath, name -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.reuseIdentifier, for: indexPath) as? FriendCell else { return nil }
            
            cell.nameLabel.text = name
            cell.backgroundColor = .tertiarySystemBackground
            cell.layer.cornerRadius = 8.0
            return cell
        }
        
        guard let dataSource = self.dataSource else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(zones)
        dataSource.apply(snapshot,
                         animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 20
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.4))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group: NSCollectionLayoutGroup
        
        switch layoutMode {
        case .grid:
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
            group.interItemSpacing = .fixed(spacing)
        case .list:
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                        leading: 10,
                                                        bottom: 10,
                                                        trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

