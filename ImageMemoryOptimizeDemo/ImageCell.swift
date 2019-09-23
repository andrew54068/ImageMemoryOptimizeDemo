//
//  ImageCell.swift
//  ImageMemoryOptimizeDemo
//
//  Created by kidnapper on 2019/9/23.
//  Copyright © 2019 andrew54068. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    func setUpImage(_ imageURL: URL) {
        if let imageData = try? Data(contentsOf: imageURL) {
            imageView.image = UIImage(data: imageData)
            return
        }
        fatalError("file not exit")
    }
    
    func setUpImage(_ image: UIImage) {
        imageView.image = image
    }

}
