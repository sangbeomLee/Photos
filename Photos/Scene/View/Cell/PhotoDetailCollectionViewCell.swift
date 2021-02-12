//
//  PhotoDetailCollectionViewCell.swift
//  Photos
//
//  Created by 이상범 on 2021/02/10.
//

import UIKit

class PhotoDetailCollectionViewCell: UICollectionViewCell {
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with photo: PhotoModel) {
        photoImageView.image = photo.thumbImage?.resizedImage(targetSize: frame.size)
    }
}

private extension PhotoDetailCollectionViewCell {
    func setupLayout() {
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
