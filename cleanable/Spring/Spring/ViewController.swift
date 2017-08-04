//
//  ViewController.swift
//  Spring
//
//  Created by byung-soo kwon on 2017. 7. 25..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit
import Photos
class ViewController: UIViewController {
    let imageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection: PHAssetCollection!
    var isChange = true
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        isChange = false
        collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var color: UIColor = UIColor.black
        let imageView = UIImageView()
        let asset = fetchResult.object(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath)
        if self.isChange {
            imageManager.requestImage(for: asset, targetSize: CGSize(width:59,height:50), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
                
                color = self.extractColor(image: image!)
                cell.backgroundColor = color
            })
        } else {
            imageManager.requestImage(for: asset, targetSize: CGSize(width:59,height:50), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
                imageView.image = image
                cell.backgroundView = imageView
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
}


extension ViewController {
    
    func extractColor(image: UIImage) -> UIColor{
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!,in: CGRect(x: 0, y: 0, width: 1, height: 1))
        var color: UIColor? = nil
        
        if pixel[3] > 0 {
            let alpha:CGFloat = CGFloat(pixel[3]) / 255.0
            let multiplier:CGFloat = alpha / 255.0
            
            color = UIColor(red: CGFloat(pixel[0]) * multiplier, green: CGFloat(pixel[1]) * multiplier, blue: CGFloat(pixel[2]) * multiplier, alpha: alpha)
        }else{
            color = UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: CGFloat(pixel[3]) / 255.0)
        }
        
        print(toHexString(color: color!) )
        pixel.deallocate(capacity: 4)
        return toHexString(color: color!)
    }
    
    func toHexString(color: UIColor) -> UIColor {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        let colorHex = String(format:"%06x", rgb)
        return hexStringToUIColor(hex: colorHex)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
