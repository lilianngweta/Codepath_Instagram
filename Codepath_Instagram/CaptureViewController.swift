//
//  CaptureViewController.swift
//  Codepath_Instagram
//
//  Created by Lilian Ngweta on 3/5/16.
//  Copyright © 2016 Lilian Ngweta. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var takenImageView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTakePhoto(sender: AnyObject) {
        
        let cameraSource = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        let sourceType = cameraSource ? UIImagePickerControllerSourceType.Camera: UIImagePickerControllerSourceType.PhotoLibrary
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = sourceType
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

    
    @IBAction func onSubmit(sender: AnyObject) {
        
        
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(takenImageView.image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = captionField.text
        //post["likesCount"] = 0
        //post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                
                print("There is an error")
            } else {
                self.tabBarController!.selectedIndex = 0
            }
        }
        
    }
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            
            let scaledImage = self.resize(image, newSize: CGSizeMake(750, 750))
            
            if let imageData = UIImageJPEGRepresentation(scaledImage, 0) {
                return PFFile(name: "image.jpg", data: imageData)
            }
        }
        return nil
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            takenImageView.image = originalImage
            
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
