//
//  PhotosTableViewCell.swift
//  Photos
//
//  Created by 이상범 on 2021/02/08.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    // TODO: - 정리하기 -> 어떻게 self resizing 을 할까 하다가 이런 식으로 적용했다.
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
        subtitleLabel.text = "Sponsor"
        photoImageView.image = photo.thumbImage
        subtitleLabel.isHidden = photo.isSponsor ? false : true
    }
}

private extension PhotosTableViewCell {
    func setupView() {
        setupPhotoImageView()
    }
    
    func setupPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFit
    }
}
