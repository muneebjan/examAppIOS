//
//  ViewController.swift
//  QAapp
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 devstop. All rights reserved.
//

import UIKit
import AWSS3

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //// UI OBJECTS
    
    let camButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OPEN CAMERA", for: .normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(camButtonHandler), for: .touchUpInside)
        return button
    }()
    
    //// VARIABLES
    
    var imagePicker: UIImagePickerController!
    let capturedImage = UIImageView()
    var imageupload: UIImage?
    
    
    // MARK:- S3 BUCKET INFORMATION
    //constants
    
    let S3BucketName: String = "quizexam"
    var S3UploadKeyName: String = ".png"
    let baseURL = "https://s3.us-east-2.amazonaws.com/quizexam/"
    
    //S3 Inits
    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    var progressBlock: AWSS3TransferUtilityProgressBlock?
    let transferUtility = AWSS3TransferUtility.default()
    
    // MARK:- VIEW WILL APPEAR
    //// VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = true
        
    }
    // MARK:- VIEW DID LOAD
    //// VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        

        
        setupViews()
        
        // s3 async
        // MARK:- S3 ASYNC FUNCTIONS
        self.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                
                print("Uploading is starting...")
            })
        }
        
        self.completionHandler = { (task, error) -> Void in
            
            
            
            DispatchQueue.main.async(execute: {
                if let error = error {
                    print("Failed with error: \(error)")
                    print("failed")
                }
                    
                else{
//                    UIViewController.removeSpinner(spinner: sv)
//                    self.displayMyAlertMessage(userMessage: "success")
                    print("Success")
                }
            })
        }
        
        
    }

    // MARK:- RESIZING IMAGE FUNCTION
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // MARK:- Upload Image function
    
    func uploadImage(with data: Data) {
//        let sv = UIViewController.displaySpinner(onView: self.view)
        let expression = AWSS3TransferUtilityUploadExpression()
        
        transferUtility.uploadData(
            data,
            bucket: S3BucketName,
            key: S3UploadKeyName,
            contentType: "image/png",
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        print("failed")
                    }
                }
                
                if let _ = task.result {
                    
                    DispatchQueue.main.async {
                        print("Generating Upload File")
                        print("Upload Starting!")
                        print("Uploading Successful!")
//                        UIViewController.removeSpinner(spinner: sv)
                    }
                    
                    // Do something with uploadTask.
                }
                
                return nil;
        }
    }
    
    //// PRIVATE FUNCTIONS
    // MARK:- PRIVATE FUNCTIONS
    fileprivate func setupViews() {
        
        view.addSubview(camButton)
        
        view.addSubview(capturedImage)
        
        camButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        camButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        camButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        camButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        capturedImage.backgroundColor = .red
        capturedImage.translatesAutoresizingMaskIntoConstraints = false
        capturedImage.topAnchor.constraint(equalTo: camButton.bottomAnchor, constant: 10).isActive = true
        capturedImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        capturedImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        capturedImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
    }
    
    //// OBJECTIVE C FUNCTIONS
    // MARK:- OBJECTIVE C FUNCTIONS
    @objc func camButtonHandler(){
        print("open camera")
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
//        navigationController?.pushViewController(SecondViewController(), animated: true)
        
    }
    
    //// IMAGEPICKER DELEGATE FUNCTIONS
    // MARK:- IMAGEPICKER DELEGATE FUNCTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        capturedImage.image = info[.originalImage] as? UIImage
        imageupload = capturedImage.image
        
        let currentDateTime = Date()
        let stringTime = "Image_\(currentDateTime.timeIntervalSinceReferenceDate)"
        
        if let image = imageupload{
            
            S3UploadKeyName = stringTime.appending(".png")
            
            let imageurl = baseURL+self.S3UploadKeyName
            self.uploadImage(with: self.resizeImage(image: self.imageupload!, targetSize: CGSize(width: 400, height: 400)).pngData()!)
            
            print("imageURL: \(imageurl)")
            
        }else{
            print("error here")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(QAscreen(), animated: true)

    }
    
    // display ALERT FUNCTION
    // MARK:- display ALERT FUNCTION
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
    }
    
    
}

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 30
        
        layer.add(flash, forKey: nil)
        
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}


extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
