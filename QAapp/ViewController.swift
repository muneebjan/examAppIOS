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
    
    let backgroundImage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "background.png")
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "Scan Quiz Paper"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 23)
        //        label.font = UIFont.systemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let camButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("OPEN CAMERA", for: .normal)
//        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setImage(UIImage(named: "camera.png"), for: .normal)
        button.tintColor = .white
//        button.imageView?.tintColor = .white
//        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(camButtonHandler), for: .touchUpInside)
        return button
    }()
    
    //// VARIABLES
    
    var imagePicker: UIImagePickerController!
    var imageupload: UIImage?
    var sv = UIView()
    
    // MARK:- S3 BUCKET INFORMATION
    //constants
    
    let S3BucketName: String = "quizexam"
    var S3UploadKeyName: String = ".png"
    let baseURL = "https://s3.us-east-2.amazonaws.com/quizexam/"
    var uploadedImageurl = String()
    
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
//                    self.displayMyAlertMessage(userMessage: "success")
                    print("Success")
                    UIViewController.removeSpinner(spinner: self.sv)
                    self.gettingDataFromApi(imageurl: self.uploadedImageurl)
//                    ToastView.shared.short(self.view, txt_msg: "Image Uploaded Successfull")
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
    
    private func gettingDataFromApi(imageurl: String){
        
//        let imageurl = "https://s3.us-east-2.amazonaws.com/quizexam/Image_588691588.181878.png"
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        AuthServices.instance.updateImageURLtoDatabase(imageURL: imageurl) { (success) in
            if(success){
                print("api successfull")
                UIViewController.removeSpinner(spinner: sv)
                self.navigationController?.pushViewController(ScanImageAndShowQA(), animated: true)
            }else{
                print("not successfull")
                UIViewController.removeSpinner(spinner: sv)
            }
        }
        
    }
    
    // MARK:- Upload Image function
    
    func uploadImage(with data: Data) {
        
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
                    }
                    
                    // Do something with uploadTask.
                }
                
                return nil;
        }
    }
    
    //// PRIVATE FUNCTIONS
    // MARK:- PRIVATE FUNCTIONS
    fileprivate func setupViews() {
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLable)
        view.addSubview(camButton)
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
        
        titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let centerY = NSLayoutConstraint(item: titleLable, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.5, constant: 0)
        
        NSLayoutConstraint.activate([centerY])
        
        camButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        camButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        camButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        camButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        
    }
    
    //// OBJECTIVE C FUNCTIONS
    // MARK:- OBJECTIVE C FUNCTIONS
    
    func openCamera(){
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)

    }
    
    func openGallery(){
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func camButtonHandler(){
        print("open camera")
//        imagePicker =  UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .camera
//        present(imagePicker, animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //// IMAGEPICKER DELEGATE FUNCTIONS
    // MARK:- IMAGEPICKER DELEGATE FUNCTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageupload = editedImage
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageupload = image
        }
        
//        capturedImage.image = info[.originalImage] as? UIImage
//        imageupload = capturedImage.image
        
        let currentDateTime = Date()
        let stringTime = "Image_\(currentDateTime.timeIntervalSinceReferenceDate)"
        
        if let image = imageupload{
            
            S3UploadKeyName = stringTime.appending(".png")
            
            self.uploadedImageurl = baseURL+self.S3UploadKeyName
            
            self.uploadImage(with: self.imageupload!.pngData()!)
            print("imageURL: \(uploadedImageurl)")
            
        }else{
            print("error here")
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
//        navigationController?.pushViewController(QAscreen(), animated: true)
        
        self.sv = UIViewController.displaySpinner(onView: self.view)

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

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
