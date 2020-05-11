//
//  ProductsTableViewController.swift
//  Sneakersell
//
//

import UIKit

class ProductsTableViewController: UITableViewController {
  private var products: [Product]?
  private let identifer = "productCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    products = [
      Product(name: "OFF-WHITE x Air Jordan 1 Retro High OG 'White' 2018", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
      Product(name: "OFF-WHITE x Air Jordan 5 Retro SP 'Muslin'", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
      Product(name: "Yeezy Basketball 'Quantum'", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
      Product(name: "Air Jordan 6 Retro 'Infrared' 2019", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
    ]
  }


  // MARK: - View Transfer
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showProduct" {
      if let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell),
        let productVC = segue.destination as? ProductViewController {
        productVC.product = products?[indexPath.row]
      }
    }
  }
}


// MARK: - UITableViewDataSource
extension ProductsTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return products?.count ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath)
        guard let products = products else { return cell }

        cell.textLabel?.text = products[indexPath.row].name

        if let imageName = products[indexPath.row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }

        return cell;
    }
}
