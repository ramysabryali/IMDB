//
//  MovieCollectionViewCell.swift
//  IMDB
//
//  Created by Ramy Sabry on 15/04/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var imageView: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentContainerView.layer.masksToBounds = false
        contentContainerView.layer.shadowRadius = 5
        contentContainerView.layer.shadowOpacity = 5
        contentContainerView.layer.shadowColor = UIColor.gray.cgColor
        
        contentContainerView.clipsToBounds = true
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func loadCell(
        with title: String?,
        and imageURL: String?,
        and voteAverage: Double?
    ) {
        titleLabel.text = title
        ratingNumberLabel.text = "\(voteAverage ?? 0)"
        imageView.setImage(using: imageURL)
    }
}
