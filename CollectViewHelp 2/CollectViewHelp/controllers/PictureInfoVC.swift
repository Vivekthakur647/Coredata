//
//  PictureInfoVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/29/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class PictureInfoVC: UIViewController {
    
    
  
    private var dataSource = CollectionViewDataSource()
   
    var _imageTemp : UIImage!
    var image = UIImage()
    
    
    let discTypeArray = ["Driver", "Hydrid", "Mid-Range", "Putter","Backups", "Other"]
    var selectedDiscType : String?
    var name : String?
    var UserDescription: String?
    
    
    
    
    
    
    
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var discTypeTF: UITextField!
    
    @IBOutlet weak var descriptTF: UITextView!
    
    @IBOutlet weak var discInfoTextView: UITextView!
    
    @IBOutlet weak var SaveBTNOutlet: additionButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: UIColor.green, colorTwo: UIColor.blue)
        SaveBTNOutlet.backgroundColor = UIColor.blue
        
        imageThumbnail.image = _imageTemp
        imageThumbnail.layer.cornerRadius = imageThumbnail.frame.height / 2
        imageThumbnail.layer.masksToBounds = true
        
        
        descriptTF.layer.cornerRadius = 5
        
        descriptTF.delegate = self
        descriptTF.text = "Memories,Flight description, etc"
        descriptTF.textColor = UIColor.lightGray
   
       hideKeyboardAndUpdate()
       createDiscTypePicker()
        
    }

    
    
    
    
    
    
    
    
    
    

    @IBAction func SaveInfoBTN(_ sender: Any) {
     //    discInfoTextView.text = "Name: \(nameTF.text!)\nType: \(discTypeTF.text!)"
        
        if name == nil {
            name = "N/A"
        }
        if selectedDiscType == nil {
            selectedDiscType = "Other"
        }
        if UserDescription == nil {
            UserDescription = "N/A"
        }
        
        
        
        prepareImageForSaving(image: _imageTemp, name: name!, description: UserDescription!, type: selectedDiscType!)
    
        
        dismiss(animated: true , completion: nil)
        
    }
    
  
    
    
    func updateTextView() {
       
        
        name = nameTF.text!
        UserDescription = descriptTF.text!
        selectedDiscType = discTypeTF.text!
        
   
        discInfoTextView.text = "Name: \(name!)\nType: \(selectedDiscType!)\nDescription: \(UserDescription!)"
    }
    
   
    
    
    // Method for saving info into coredata

    func prepareImageForSaving(image:UIImage, name: String, description: String, type: String) {
        
        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970
        
        
        // create NSData from UIImage
        guard let imageData = UIImagePNGRepresentation(image) else {
            // handle failed conversion
            print("png error")
            return
        }
        
        
        
        saveImage(imageData: imageData as NSData, date: date, name: name, description: description, type: type)
    }

    
    func saveImage(imageData:NSData, date: Double, name: String, description: String, type: String) {
        
        
        let collectionImages = CollectViewImages(context: PersistenceService.context)
        collectionImages.id = date
        collectionImages.imageData = imageData
        collectionImages.discName = name
        collectionImages.discDescription = description
        collectionImages.discType = type
        
        PersistenceService.saveContext()
        
    }
    
    
    
    
    
    func createDiscTypePicker() {
        let typePicker = UIPickerView()
        typePicker.delegate = self
        discTypeTF.inputView = typePicker
    }


}



extension PictureInfoVC: UITextFieldDelegate, UITextViewDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            }
        }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Memories,Flight description, etc"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    }

extension PictureInfoVC : UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return discTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return discTypeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDiscType = discTypeArray[row]
        discTypeTF.text = selectedDiscType
        updateTextView()
    }
    
}


extension PictureInfoVC
{
    func hideKeyboardAndUpdate()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(PictureInfoVC._dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func _dismissKeyboard()
    {
        view.endEditing(true)
        updateTextView()
    }
}















