//
//  ImageControl.swift
//  cleanable
//
//  Created by byung-soo kwon on 2017. 8. 4..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class ImageControl: UIStackView {
    
    private var collectionImages: [UIImageView] = []
    var imageCount = 5 {
        didSet {
            setupImages()
        }
    }
    var imageSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupImages()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupImages()
    }
    
    private func setupImages() {
        
        for images in collectionImages {
            removeArrangedSubview(images)
            images.removeFromSuperview()
        }
        collectionImages.removeAll()
        
        for _ in 0..<imageCount {
            
            let imageView = UIImageView()
            //TODO: imageView Setting
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
            
            addArrangedSubview(imageView)
            collectionImages.append(imageView)
        }
    }
}
