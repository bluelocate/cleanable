//
//  LocationSortViewController.swift
//  cleanable
//
//  Created by byung-soo kwon on 2017. 8. 4..
//  Copyright © 2017년 5InQueue. All rights reserved.
//

import UIKit

class LocationSortViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       }
}


extension LocationSortViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationPhotoItem", for: indexPath)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FetchedImages.count
    }
}
