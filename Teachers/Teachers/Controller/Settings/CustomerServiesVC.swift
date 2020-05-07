//
//  CustomerServiesVC.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
class CustomerServiesVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var contacttitle: UITextField!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var sendTitle: UIButton!
    @IBOutlet weak var exitTitle: UIButton!
    
    var imagepath = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        sendTitle.setTitle("SendTitle".localized, for: .normal)
        exitTitle.setTitle("ExitTitle".localized, for: .normal)
//        contacttitle.placeholder = "messegtitle".localized
        contacttitle.attributedPlaceholder = NSAttributedString(string: "messegtitle".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func file(_ sender: Any) {
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "Photolibrary".localized, message: "", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    let messeagePhoto = URL(string:"\(urlPath)")!
                    self.imagepath = path!
                    print("Message",messeagePhoto)
                    HUD.flash(.success, delay: 2.0)
                }
            }
        self.dismiss(animated: true, completion: nil)
        HUD.show(.progress)
    }
    @IBAction func sendmsg(_ sender: Any) {
        if contacttitle.text?.isEmpty == true{
                AlertHandler().displayMyAlertMessage(message: "messegtitle".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if message.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "messegebody".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else{
            
            WebServices.instance.contactus(imgpath: imagepath, title: contacttitle.text!, message: message.text!, completion: { (status, error) in
                print("aaaaaa")
                if status {
                    HUD.flash(.success, delay: 2.0)
                    self.contacttitle.text = ""
                    self.message.text = ""
                    print("asdasdasdasd")
                }else if error == ""{
                     HUD.flash(.error, delay: 2.0)
                   
                }
            })
        }
    }
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isConnectedToNetwork() == true {
            print("Internet connection OK")
        } else {
            AlertHandler().displayMyAlertMessage(message: "InternetconnectionFAILED".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
        }

        self.navigationItem.title = "CUSTOMER".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
