//
//  ImageManager.swift
//  cleanable
//
//  Created by byung-soo kwon on 2017. 8. 4..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import Foundation
import Photos

var FetchedImages = ImageManager.shared
class ImageManager {
    let imageManager = PHCachingImageManager()
    var assetCollection = PHAssetCollection()
    static var shared = PHFetchResult<PHAsset>()
    
    func fetchPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
        FetchedImages = PHAsset.fetchAssets(with: allPhotosOptions)
    }
}
    
