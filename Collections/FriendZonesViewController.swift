//
//  FriendZonesViewController.swift
//  Collections
//
//  Created by Joben Gohlke on 9/14/20.
//  Copyright © 2020 Ben Gohlke. All rights reserved.
//

import UIKit

class FriendZonesViewController: UIViewController {
  
  enum Section: CaseIterable {
    case main
  }
  
  var collectionView: UICollectionView! = nil
  
  private var zones: [String] = ["Ayanna Kosoko",
                                 "Fernando Olivares",
                                 "Spencer Curtis",
                                 "Ben Gohlke",
                                 "Dimitri Bouniol",
                                 "Johnny Hicks",
                                 "Paul Solt"]
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Friend Zone"
    configureCollectionView()
    configureDataSource()
    configureNavbar()
  }
  
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
    
  }
}

extension FriendZonesViewController {
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    view.addSubview(collectionView)
    
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .secondarySystemBackground
    collectionView.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.reuseIdentifier)
  }
  
  private func configureDataSource() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
//  private func createLayout() -> UICollectionViewLayout {
//
//  }
}

extension FriendZonesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return zones.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.reuseIdentifier, for: indexPath) as? FriendCell else {
      fatalError("Could not dequeue cell of type: \(FriendCell.reuseIdentifier)")
    }
    
    cell.nameLabel.text = zones[indexPath.item]
    cell.backgroundColor = .tertiarySystemBackground
    cell.layer.cornerRadius = 8.0
    
    return cell
  }
}

extension FriendZonesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 200)
  }
}
