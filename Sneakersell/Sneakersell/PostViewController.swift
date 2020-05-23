//
//  PostViewController.swift
//  Sneakersell
//
//

import UIKit
import Photos
import FirebaseStorage
import FirebaseDatabase

class PostViewController: UIViewController {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var imgUpload: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSize: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    var uploadImage : UIImage!
    var storage : Storage!
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
    }
    
    override func viewDidLayoutSubviews() {
        self.configureView()
    }
    
    func configureView(){
        self.nameView.customInputView()
        self.sizeView.customInputView()
        self.priceView.customInputView()
        self.phoneNumberView.customInputView()
        self.btnPost.btnRoundCorner()
        self.imgUpload.layer.cornerRadius = 20
    }
    
    @IBAction func imgPressed(_ sender: Any) {
        self.actionSheet()
    }
    
    func actionSheet(){
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.openCamera()
            print("First Action pressed")
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) { action -> Void in
            self.openPhotoLibrary()
            print("Second Action pressed")
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        actionSheetController.popoverPresentationController?.sourceView = self.view

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func postPressed(_ sender: Any) {
        if self.checkForValidations() {
            self.imageUpload()
        } else {
            Common.shared.showAlert(withTitle: "Error", andMessage: "Please enter all the required data.", andVc: self)
        }
    }
    
    func imageUpload(){
        print("uploading image now")
        self.storage = FirebaseStorage.Storage.storage()
        let storageRef = storage.reference()
        let imgName = NSUUID().uuidString
        let sneakerImageRef = storageRef.child("SneakerImages/\(imgName).jpg")
        
        let data = self.uploadImage.pngData()!
        Common.shared.showLoader(self)
        _ = sneakerImageRef.putData(data, metadata: nil) { (metadata, error) in
            Common.shared.dismissLoader()
          guard let metadata = metadata else {
            return
          }
            _ = metadata.size
          sneakerImageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              return
            }
            print(downloadURL)
            self.saveDataInDb(imageUrl: downloadURL)
          }
        }
    }
    
    func saveDataInDb(imageUrl : URL){
        let postId = self.ref.child("sneaker").childByAutoId()
        postId.setValue(["SneakerId": postId.key, "SneakerName": self.txtName.text!, "SneakerSize": self.txtSize.text!, "SneakerImage": imageUrl.absoluteString, "SneakerPrice": self.txtPrice.text!, "PhoneNumber": self.txtPhone.text!]) { (error, ref) in
            //Common.shared.dismissLoader()
            if error != nil {
                Common.shared.showAlert(withTitle: "Error", andMessage: error!.localizedDescription, andVc: self)
                return
            } else {
                Common.shared.showAlertWithOption(title: "Success", message: "Sneaker Posteed", viewController: self) { (true) in
                    self.navigationController?.popViewController(animated: true)
                    NotificationCenter.default.post(name: Notification.Name.CallSneakersNotification, object: nil)
                }
            }
        }
    }
    
    
    func checkForValidations() -> Bool{
        if self.uploadImage == nil || self.txtName.text == "" || self.txtSize.text == "" || self.txtPhone.text == "" || self.txtPrice.text == "" {
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.uploadImage = UIImage()
//            self.imageAttachment = image
//            self.dismiss(animated: true, completion: nil)
            
            if let updatedImage = image.updateImageOrientionUpSide() {
                self.uploadImage = updatedImage
                self.imgUpload.image = self.uploadImage
            } else {
                self.uploadImage = image
                self.imgUpload.image = self.uploadImage
            }
            self.dismiss(animated: true, completion: nil)
            
        } else {
            print("something went wrong")
        }
    }
}
