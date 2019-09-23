//
//  ViewController.swift
//  ImageMemoryOptimizeDemo
//
//  Created by kidnapper on 2019/9/16.
//  Copyright © 2019 andrew54068. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: (UIScreen.main.bounds.width - 30) / 2, height: (UIScreen.main.bounds.width - 30) / 2)
        let view: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private lazy var imageURLs: [URL] = {
        var urls: [URL] = []
        for i in 0...32 {
            let path = Bundle.main.path(forResource: "img_" + "\(i)", ofType: "jpg")!
            let fileURL = URL(fileURLWithPath: path)
            urls.append(fileURL)
        }
        return urls
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        let image = downsample(imageAt: imageURLs[indexPath.item], maxDimentionInPixels: cell.bounds.width)
        cell.setUpImage(image)
        return cell
    }
    
}

extension ViewController {
    
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
    
    func downsample(imageAt imageData: Data, maxDimentionInPixels: CGFloat) -> UIImage {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions)!
        let downsampledOptions = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                  kCGImageSourceShouldCacheImmediately: true,
                                  kCGImageSourceCreateThumbnailWithTransform: true,
                                  kCGImageSourceThumbnailMaxPixelSize: maxDimentionInPixels] as CFDictionary
        
        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampledOptions)!
        
        return UIImage(cgImage: downsampledImage)
    }
    
    func downloadFromUrl(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let data = data else { return }
            completion(self.downsample(imageAt: data, maxDimentionInPixels: 300))
            }.resume()
    }
    
}
