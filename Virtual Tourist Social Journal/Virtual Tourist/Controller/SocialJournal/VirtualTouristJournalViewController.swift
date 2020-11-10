//
//  VirtualTouristJournal.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 11/15/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit

class VirtualTouristJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var camaraButton: UIBarButtonItem!
    
    var travelImage = UIImage()
    
    let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -2.5,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            shareButton.isEnabled = false
            setup(textField: bottomTextField)
            bottomTextField.text = "BOTTOM"
        }
        func setup(textField: UITextField) {
            textField.delegate = self
            textField.defaultTextAttributes = textAttributes
            textField.textAlignment = .center
            textField.backgroundColor = .clear
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            camaraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotifications()
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            unsubscribeFromKeyboardNotifications()
        }
    
    @IBAction func pickAnAlbumImage(_ sender: Any) {
        openImagePicker(.photoLibrary)
    }
    func openImagePicker(_ type: UIImagePickerController.SourceType){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = (.photoLibrary)
            present(imagePicker, animated: true, completion: nil)
        }
        
    @IBAction func pickACamaraImage(_ sender: Any) {
    }

    func generateImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let travelImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return travelImage
    }
    @IBAction func shareJournal(_ sender: Any) {
        let image = generateImage()
            let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            controller.completionWithItemsHandler = { (_,isCompleted,_,_) in
                if isCompleted {
                    self.save()
                }
            }
            present(controller, animated: true, completion: nil)
        }
    func save() {
        _ = SocialJournal(bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, journalImage: travelImage)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
                imagePickerView.image = image
                shareButton.isEnabled = true
            }
            dismiss(animated: true, completion: nil)
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
             textField.text = ""
         }
         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
             return true
         }
         @objc func keyboardWillShow(_ notification:Notification) {
                 if bottomTextField.isFirstResponder {
                     view.frame.origin.y = getKeyboardHeight(notification) * (-1)            }
             }
             func getKeyboardHeight(_ notification:Notification) -> CGFloat {
             let userInfo = notification.userInfo
             let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
             return keyboardSize.cgRectValue.height
         }
         func subscribeToKeyboardNotifications() {
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         }
         func unsubscribeFromKeyboardNotifications() {
             NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
         }
         @objc func keyboardWillHide(_ notificatioin: Notification)  {
             self.view.frame.origin.y = 0.0
         }
    
}
