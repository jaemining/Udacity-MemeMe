//
//  ImageViewController.swift
//  MemeMe
//
//  Created by LimJaemin on 2017. 1. 28..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
