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

    @IBAction func pickAnImageFromPhotoLibrary(_ sender: Any) {
        let pickerController = UIImagePickerController()
        
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false) { () in
            let alert = UIAlertController(title:"", message: "이미지 선택이 취소되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: false) { () in
            let image = info[UIImagePickerControllerEditedImage] as? UIImage
            self.imageView.image = image
        }
    }

}

