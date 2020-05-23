//
//  Common.swift
//  Sneakersell
//
//

import Foundation
import UIKit
import JGProgressHUD

class Common {
    
    static let shared = Common()
    
    private var hud : JGProgressHUD!
    
    func showAlert(withTitle title : String, andMessage message: String, andVc vc : UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithOption(title: String, message: String, viewController vc: UIViewController, success:@escaping ((_ status:Bool)->Void)){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            success(true)
        }))
        
    }
    
    func showLoader(_ vc: UIViewController) {
        hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: vc.view)
    }
    
    func dismissLoader() {
        hud.dismiss()
    }
}
