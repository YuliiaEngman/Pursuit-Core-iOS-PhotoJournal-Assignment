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
    
    public var image = ImageObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
