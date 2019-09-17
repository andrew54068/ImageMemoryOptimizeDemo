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
        
        imageView.image = UIImage(named: "PNG_800_600")!
    }

}
