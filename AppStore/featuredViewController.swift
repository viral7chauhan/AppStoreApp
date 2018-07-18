//
//  ViewController.swift
//  AppStore
//
//  Created by Viral Chauhan on 07/02/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class featuredViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var appsCategory : [AppCategory]?
    private let cellId = "CellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCategory.fetchDataFromWeb { (appsCategories) in
            self.appsCategory = appsCategories
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appsCategory?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategories = appsCategory?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
}


