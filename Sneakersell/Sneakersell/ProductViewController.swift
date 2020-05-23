//
//  ViewController.swift
//  Sneakersell
//
//

import UIKit
import Kingfisher

class ProductViewController: UIViewController {

  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
    @IBOutlet weak var imgNavBar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var imgSneaker: UIImageView!
    
    
    var sneaker: Sneaker?
  var product: Product?

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    productNameLabel.text = product?.name
//
//    if let imageName = product?.fullscreenImageName {
//      productImageView.image = UIImage(named: imageName)
//    }
    self.configureView()
    
  }
    
    func configureView(){
        self.lblName.text = self.sneaker?.SneakerName
        self.productNameLabel.text = self.sneaker?.SneakerName
        self.lblSize.text = self.sneaker?.SneakerSize
        self.lblPrice.text = self.sneaker?.SneakerPrice
        self.lblPhone.text = self.sneaker?.PhoneNumber
        let url = URL(string: self.sneaker?.SneakerImage ?? "")
        self.imgSneaker.kf.setImage(with: url)
        
    }
    
    override func viewDidLayoutSubviews() {
        self.imgNavBar.layer.cornerRadius = 20
    }

  @IBAction func addToCartButtonDidTap(_ sender: AnyObject) {
    print("Add to cart successfully")
  }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
