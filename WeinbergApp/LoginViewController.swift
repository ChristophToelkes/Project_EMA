//
//  LoginViewController.swift
//  WeinbergApp
//
//  Created by Elena Görgen on 16.06.18.
//  Copyright © 2018 Christoph Tölkes. All rights reserved.
//




import AVFoundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordtextField: UITextField!
    private var showPassword : Bool!
   
    
    
    //---für QR Gedöns---
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let testName = "hhh"
    let testPassword = "hhh"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPassword = false
    }
    
    private func checkTextFields() -> Bool{
        guard userNameTextField.text != "" else {return false}
        guard userPasswordtextField.text != "" else {return false}
        return true
    }

    @IBAction func loginBtn(_ sender: Any) {
        if(checkTextFields()){
            if(checkLoginValuesDB()){
                
                //--- danach zur nächsten UI weiterleiten---
                performSegue(withIdentifier: "segueToMapView", sender: self)

                print("angemeldet")
            }
        }
       
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        //--- Neuen User in DB anlegen---
        //--- danach zur nächsten UI weiterleiten---
        

        
        
        performSegue(withIdentifier: "segueToScannerView", sender: self)
        print("registrieren")
      
    }
    
    private func checkLoginValuesDB() -> Bool {
        guard let userName = userNameTextField.text else {return false}
        guard let userPassword = userPasswordtextField.text else {return false}
        let shakeHelper = ShakeAnimationHelper()
        
        //---hier muss später die Überprüfung der Daten mit der Datenbank(lokal) stattfinden---
        
        if(userName == testName){
            if(userPassword == testPassword){
                
                //---userPassword & userName correct---
                return true
                
            }else{
                userPasswordtextField.layer.add(shakeHelper.shake(centerOfControl: userPasswordtextField.center),
                                                                            forKey: "position")
            }
        } else {
            let alert = UIAlertController(title: "Benutzer unbekannt", message: "Der Benutzer "+userNameTextField.text!+" konnte nicht gefunden werden. Alternativ können Sie sich registrieren.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Registrieren", style: .default, handler: { (nil) in
                self.signinBtn((Any).self)
            }))
            alert.addAction(UIAlertAction(title: "zurück", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        return false
        
    }
    
    @IBAction func showPasswordBtn(_ sender: Any) {
        if(showPassword == false) {
            userPasswordtextField.isSecureTextEntry = false
            showPassword = true
        } else {
            userPasswordtextField.isSecureTextEntry = true
            showPassword = false
        }
    }
}

