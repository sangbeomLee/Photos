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
 
    var isUpdated: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForReuse() {
        photoImageView.image = .none
        isUpdated = false
    }
    
    func configure(by photo: PhotoModel) {
        titleLabel.text = photo.userName
        subtitleLabel.text = "Sponsor"
        photoImageView.image = photo.thumbImage
        subtitleLabel.isHidden = photo.isSponsor ? false : true
    }
    
    func setImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if isUpdated { return }
        PhotoAPIProvider.shared.downloadImage(from: url) { (result) in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(_):
                completion(nil)
            }
        }
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
