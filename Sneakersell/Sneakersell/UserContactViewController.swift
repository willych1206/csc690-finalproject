//
//  UserContactViewController.swift
//  Sneakersell
//

import UIKit

class UserContactViewController: UIViewController {

    @IBOutlet weak var imgNavBar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    override func viewDidLayoutSubviews() {
        self.imgNavBar.layer.cornerRadius = 20
    }
    
    func configureView(){
        self.navigationController?.navigationBar.isHidden = true
    }
}
