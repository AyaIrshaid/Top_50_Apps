//
//  ViewController.swift
//  Top50FreeApps
//
//  Created by Aya Irshaid on 5/19/19.
//  Copyright © 2019 Aya Irshaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let cellId = "AppItemCell"
    var appViewModels: [AppViewModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set collectionView delegate and dataSource
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        
        // register nib file
        collectionView.register(UINib(nibName: "AppItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellId)
        
        // get data
        DataService.fetchAppData(completionHandler: { (data) in
            self.appViewModels = data
            self.collectionView.reloadData()
        })
    }
    
    
}


// MARK: - Collection View Delegate and DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AppItemCell
        
        cell?.appNameLabel.text = appViewModels[indexPath.row].appName
        cell?.appImageView.loadImageUsingCacheWithUrlString(urlString: appViewModels[indexPath.row].imageURL)
        
        return cell!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get 'DetailsViewController' from storyboard
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        
        // set its data
        detailsVC!.appViewModel = appViewModels[indexPath.row]
        
        // show the view
        self.navigationController?.pushViewController(detailsVC!, animated: true)
    }
}

