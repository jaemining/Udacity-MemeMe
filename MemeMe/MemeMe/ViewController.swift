//
//  ViewController.swift
//  MemeMe
//
//  Created by LimJaemin on 2017. 1. 26..
//  Copyright © 2017년 LimJaemin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        
        present(pickerController, animated: true, completion: nil)
    }

}

