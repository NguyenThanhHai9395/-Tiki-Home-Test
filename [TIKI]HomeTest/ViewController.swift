//
//  ViewController.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/24/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txfKeyword: UITextField!
    @IBOutlet weak var cvwProduct: UICollectionView!
    @IBOutlet weak var cvwRecentSearch: UICollectionView!
    @IBOutlet weak var vwRecentSearch: UIView!
    
    
    
    var products: [Product] = []
    var recentSearch: [Recent] = []
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.cvwProduct.delegate = self
        self.cvwProduct.dataSource = self
        
        self.cvwRecentSearch.delegate = self
        self.cvwRecentSearch.dataSource = self
        
        setupUI()
        
        Keyword.getProduct { (error, products) in
            self.products = products!
            self.cvwProduct.reloadData()
        }
        
        loadRecent()
 
    }

    private func setupUI() {
        if let layout = cvwProduct.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 170, height: 200)
        }
        
        if let layout = cvwRecentSearch.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            layout.scrollDirection = .horizontal
        }
        
        self.cvwProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        self.cvwRecentSearch.register(UINib(nibName: "RecentSearchCell", bundle: nil), forCellWithReuseIdentifier: "RecentSearchCell")
        self.view.backgroundColor = UIColor(rgb: Constant.colors[1])
    }
    
    private func loadRecent(){
        recentSearch = Recent.getAllRecentKeyword()
        recentSearch.reverse()
        if recentSearch.count <= 0{
            vwRecentSearch.isHidden = true
        } else {
            vwRecentSearch.isHidden = false
            cvwRecentSearch.reloadData()
        }
        
    }
  
    //MARK : ACTION
    
    @IBAction func tappedSearchBtn(_ sender: Any) {
        if txfKeyword.text != "" {
            if Recent.insertKeyword(txfKeyword.text!) != nil {
                txfKeyword.text = ""
                loadRecent()
            }
        }
    }
  
    @IBAction func tappedClearBtn(_ sender: Any) {
        if Recent.deleteAll() {
            loadRecent()
        } else {
            print("error delete all")
        }
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cvwProduct {
            return products.count
        } else {
            return recentSearch.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.cvwProduct {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            
            DispatchQueue.main.async {
                let name = self.products[indexPath.row].keyword
                
                if (name?.index(of: " ")) != nil
                    && self.widthOf(text: name!) < cell.layer.bounds.width {
                    cell.lblProductWidthConstraint.constant = self.widthOf(text: name!) / 1.5
                } else {
                    cell.lblProductWidthConstraint.constant = cell.vwTitle.bounds.width - 32
                }
                cell.lblProduct.text = name
                cell.vwTitle.backgroundColor = UIColor(rgb: Constant.colors[indexPath.row % Constant.colors.count])
                cell.imvProduct.download(from: self.products[indexPath.row].icon!)
            }
            
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCell", for: indexPath) as! RecentSearchCell
            
            
            cell.backgroundColor = UIColor(rgb: Constant.colors[indexPath.row % Constant.colors.count])
            cell.lblKeyword.text = recentSearch[indexPath.row].keyword
            return cell
        }
        
    }
    
}

extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.cvwRecentSearch{
            var width: CGFloat = 0
            if let keyword = recentSearch[indexPath.row].keyword{
                if (keyword.index(of: " ")) != nil{
                    width = (widthOf(text: keyword) / 1.4 ) + 32
                } else {
                    width = widthOf(text: keyword) + 33
                }
            }
            
            return CGSize(width: width, height: 80)
        } else {
            return CGSize(width: 170, height: 200)
        }
        
    }
}

//MARK: - FUNCTION
extension ViewController{
    func widthOf(text: String) -> CGFloat{
        let font = UIFont.systemFont(ofSize: 17)
        let fontAttributes = [NSAttributedStringKey.font: font]
        
        let size = (text as NSString).size(withAttributes: fontAttributes)
        return size.width
    }
}
