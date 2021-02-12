//
//  PhotosTableViewCell.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

private enum Constant {
    static var subtitle: String { "Sponsor" }
}

class PhotosTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForReuse() {
        photoImageView.image = .none
    }
    
    func configure(by photo: PhotoModel) {
        titleLabel.text = photo.userName
        subtitleLabel.text = Constant.subtitle
        photoImageView.image = photo.image?.resizedImage(targetSize: contentView.frame.size)
        subtitleLabel.isHidden = photo.isSponsor ? false : true
    }
}

// MARK: - Setup

private extension PhotosTableViewCell {
    func setupView() {
        setupPhotoImageView()
    }
    
    func setupPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFit
    }
}
