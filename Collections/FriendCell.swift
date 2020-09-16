//
//  FriendCell.swift
//  Collections
//
//  Created by Joben Gohlke on 9/14/20.
//  Copyright © 2020 Ben Gohlke. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
  static let reuseIdentifier = "friend-cell-reuse-identifier"
  
  var nameLabel = UILabel()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FriendCell {
  private func configure() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.adjustsFontForContentSizeCategory = true
    nameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    contentView.addSubview(nameLabel)
    
    let inset: CGFloat = 8.0
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
      nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset)
    ])
  }
}
