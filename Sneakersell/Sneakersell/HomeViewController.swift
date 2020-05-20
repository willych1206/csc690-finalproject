//
//  HomeViewController.swift
//  Sneakersell
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imgNavBar: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.imgNavBar.layer.cornerRadius = 20
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
