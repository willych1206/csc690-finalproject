//
//  ProductsViewController.swift
//  Sneakersell
//

import UIKit
import FirebaseDatabase
import Kingfisher

class ProductsViewController: UIViewController {

    @IBOutlet weak var tblViewProducts: UITableView!
    @IBOutlet weak var imgNavBar: UIImageView!
    
    var ref: DatabaseReference!
    var products: [Product]?
    var sneakers : [Sneaker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.configureProducts()
        self.ref = Database.database().reference()
        self.configureTableView()
        self.callSneakers()
        self.registerNotification()
    }
    
    override func viewDidLayoutSubviews() {
        self.imgNavBar.layer.cornerRadius = 20
    }
    
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(callSneakers), name: Notification.Name.CallSneakersNotification, object: nil)
    }
    
    func configureProducts(){
        products = [
          Product(name: "OFF-WHITE x Air Jordan 1 Retro High OG 'White' 2018", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
          Product(name: "OFF-WHITE x Air Jordan 5 Retro SP 'Muslin'", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
          Product(name: "Yeezy Basketball 'Quantum'", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
          Product(name: "Air Jordan 6 Retro 'Infrared' 2019", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
    }
    
    @objc func callSneakers(){
        self.sneakers.removeAll()
        Common.shared.showLoader(self)
        ref.child("sneaker").observeSingleEvent(of: .value, with: { (snapshot) in
            Common.shared.dismissLoader()
            let value = snapshot.value as? [String: Any]
            guard let places = value else {
                return
            }
            
            for each in places {
                /*Mark: Parsing Data*/
                
                let dict = each.value as? NSMutableDictionary
                let sneakerId = dict?.value(forKey: "SneakerId") as? String
                let sneakerName = dict?.value(forKey: "SneakerName") as? String
                let sneakerSize = dict?.value(forKey: "SneakerSize") as? String
                let sneakerPrice = dict?.value(forKey: "SneakerPrice") as? String
                let sneakerImage = dict?.value(forKey: "SneakerImage") as? String
                let phoneNumber = dict?.value(forKey: "PhoneNumber") as? String
                
                
                let sneaker = Sneaker(SneakerId: sneakerId, SneakerName: sneakerName, SneakerSize: sneakerSize, SneakerPrice: sneakerPrice, SneakerImage: sneakerImage, PhoneNumber: phoneNumber ?? "")
                self.sneakers.append(sneaker)
                
            }
            self.tblViewProducts.reloadData()
            
        }) { (error) in
            //handle error case
            Common.shared.showAlert(withTitle: "Error", andMessage: "Something Went Wrong", andVc: self)
            return
        }
    }
    
    func configureTableView(){
        self.navigationController?.navigationBar.isHidden = true
        self.tblViewProducts.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        self.tblViewProducts.delegate = self
        self.tblViewProducts.dataSource = self
        self.tblViewProducts.reloadData()
    }
    
    @IBAction func homePressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}

extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sneakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        
        let sneaker = self.sneakers[indexPath.row]
        
        cell?.lblProduct.text = sneaker.SneakerName
        let imgUrl = URL(string: sneaker.SneakerImage)
        cell?.imgViewProduct.kf.setImage(with: imgUrl)
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
//
//        let product = self.products![indexPath.row]
//        vc?.product = product
        
        let sneaker = self.sneakers[indexPath.row]
        vc?.sneaker = sneaker
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension Notification.Name {
    static let CallSneakersNotification = Notification.Name("CallSneakersNotification")
}
