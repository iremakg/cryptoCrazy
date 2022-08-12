//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by irem on 2.08.2022.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchController: UISearchBar!
    
    private var cryptoListViewModel: CryptoListViewModel!
    
    var colorArray = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.colorArray = [
            UIColor(red: 10/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 100/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 10/255, green: 150/255 , blue: 170/255, alpha: 1.0),
            UIColor(red: 100/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 10/255, green: 150/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 100/255, green: 150/255, blue: 170/255, alpha: 1.0)
           
           
        ]
        
        
        getData()
        
    }
    
    
    
 private func getData() {
          
     let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
     
     Webservice().downloadCurrencies(url: url) { cryptos in
         
         if let cryptos = cryptos {
             
             self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
             
             DispatchQueue.main.async {
                 self.tableView.reloadData()
             }
         }
     }
     
 }
    
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
 }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
     
     let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
     
     cell.priceText.text = cryptoViewModel.name
     cell.currencyText.text = cryptoViewModel.price
      cell.backgroundColor = self.colorArray[indexPath.row % 6]
      
    

     return cell
 }
 

}
