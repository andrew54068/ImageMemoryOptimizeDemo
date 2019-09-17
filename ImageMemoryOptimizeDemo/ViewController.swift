//
//  ViewController.swift
//  ImageMemoryOptimizeDemo
//
//  Created by kidnapper on 2019/9/16.
//  Copyright © 2019 andrew54068. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "PNG_transparency_demonstration_1.png" , ofType: "png")!
        let fileURL = URL(fileURLWithPath: path)
        
        imageView.image = downsample(imageAt: fileURL, maxDimentionInPixels: 100)
    }

}

func downsample(imageAt imageURL: URL, maxDimentionInPixels: CGFloat) -> UIImage {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
    let downsampledOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                              kCGImageSourceShouldCacheImmediately: true,
                              kCGImageSourceCreateThumbnailWithTransform: true,
                              kCGImageSourceThumbnailMaxPixelSize: maxDimentionInPixels] as CFDictionary
    
    let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampledOptions)!
    
    return UIImage(cgImage: downsampledImage)
}
