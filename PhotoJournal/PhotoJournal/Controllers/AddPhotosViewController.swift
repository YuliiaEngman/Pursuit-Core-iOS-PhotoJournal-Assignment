//
//  AddPhotosViewController.swift
//  PhotoJournal
//
//  Created by Yuliia Engman on 2/26/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import AVFoundation

class AddPhotosViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageObjects = [ImageObject]()
    
    public var image: ImageObject?
    
    private let imagePickerController = UIImagePickerController()
    
    private let dataPersistance = PersistenceHelper(filename: "images.plist")
    
    private var selectedImage: UIImage? {
        didSet {
            appendNewPhotoToCollection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        imagePickerController.delegate = self
    }
    
    private func appendNewPhotoToCollection() {
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        print("original image size is \(image.size)")
        
        //resize image
        let size = UIScreen.main.bounds.size
        
        // we will maintain the aspect ratio of the image
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        //resize image
        let resizeImage = image.resizeImage(to: rect.size.width, height: rect.size.height)
        
        print("resized image size is \(resizeImage.size)")
        
        // jpegData(compressionQuality: 1.0 converts UIImage to Data
        guard let resizedImageData = resizeImage.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        // create an ImageObject using image selected
        //let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        
        let imageObject = ImageObject(imageData: resizedImageData, date: Date(), imageDescription: textField.text ?? "no photo description")
        
        //insert new imageObject into imageObjects
        imageObjects.insert(imageObject, at: 0)
        
        
        /*  //FIXME: I dont htink we need this code:
         // create an indexPath for insertion into collection view
         let indexPath = IndexPath(row: 0, section: 0)
         
         // insert new cell into collection view
         
         collectionView.insertItems(at: [indexPath])
         */
        
        //persist imageObject to documents directory
        do {
            try dataPersistance.create(item: imageObject)
        } catch {
            print("saving error: \(error)")
        }
    }
    
    @IBAction func photoLibraryButton(_ sender: UIButton) {
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension AddPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    // most important - what is that image - here image is come in shape of the dictionary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // we need to access the UIImagePickerController.InfoKey.originalImage key to get the UIImage that was selected
        // since we get back Any type - optional, therefore we have to unwrap it
        // now we have to downcast to UIImage (before it was just Any)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("image selected not found")
            return
        }
        selectedImage = image
        //imageView.image = image
        dismiss(animated: true)
    }
}

extension AddPhotosViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Enter photo description" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = "Enter photo description"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
