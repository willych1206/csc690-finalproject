//
//  ProductsViewController.swift
//  Sneakersell
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var tblViewProducts: UITableView!
    @IBOutlet weak var imgNavBar: UIImageView!
    
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureProducts()
        self.configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        self.imgNavBar.layer.cornerRadius = 20
    }
    
    func configureProducts(){
        products = [
          Product(name: "OFF-WHITE x Air Jordan 1 Retro High OG 'White' 2018", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
          Product(name: "OFF-WHITE x Air Jordan 5 Retro SP 'Muslin'", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
          Product(name: "Yeezy Basketball 'Quantum'", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
          Product(name: "Air Jordan 6 Retro 'Infrared' 2019", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
        ]
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
    
    
}

extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell
        
        let product = self.products![indexPath.row]
        
        cell?.lblProduct.text = product.name
        cell?.imgViewProduct.image = UIImage(named: product.cellImageName!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController
        
        let product = self.products![indexPath.row]
        vc?.product = product
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
