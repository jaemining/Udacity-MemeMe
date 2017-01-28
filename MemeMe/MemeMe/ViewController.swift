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
    @IBOutlet var textFieldTop: UITextField!
    @IBOutlet var textFieldBottom: UITextField!
    @IBOutlet var cameraButton: UIBarButtonItem!

    @IBOutlet var toolBar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldTop.textAlignment = .center
        textFieldBottom.textAlignment = .center

        textFieldTop.delegate = self
        textFieldTop.tag = 1
        textFieldBottom.delegate = self
        textFieldBottom.tag = 2

        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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

    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()

        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if(success == true && error == nil) {
                self.save(memedImage: memedImage)
            }
        }

        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func save(memedImage: UIImage) {
        let meme = Meme(textFielTop: textFieldTop.text!, textFieldBottom: textFieldBottom.text!, originalImage: imageView.image!, memedImage: memedImage)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }

    func generateMemedImage() -> UIImage {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        toolBar.isHidden = true

        UIGraphicsBeginImageContext(self.view.bounds.size)
        view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)

        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        toolBar.isHidden = false

        return memedImage
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 시작되었습니다")

        if (textField.placeholder != nil) {
            textField.placeholder = ""
        }

        if (textField.tag == 2) { // BOTTOM textField가 선택된 경우
            subscribeToKeyboardNotifications()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /***** Keyboard Adjustments *****/
    func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }

    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}

