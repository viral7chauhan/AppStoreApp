//
//  CategoryCell.swift
//  AppStore
//
//  Created by Viral Chauhan on 07/02/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var appCategories: AppCategory? {
        didSet {
            if let name = appCategories?.name {
                headerLabel.text = name
            }
        }
    }
    
    let appsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    let headerLabel : UILabel = {
        let lable = UILabel()
        lable.text = "Best New Apps"
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let darkLineView : UIView = {
        let view = UIView ()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellId = "AppCellId"
    func setupView() {
        backgroundColor = .clear
        
        [appsCollectionView, darkLineView, headerLabel].forEach{ addSubview($0) }
        
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
    
        appsCollectionView.register(AppCells.self, forCellWithReuseIdentifier: cellId)
        
        appsCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant:1).isActive = true
        appsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        appsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        appsCollectionView.bottomAnchor.constraint(equalTo: darkLineView.topAnchor ).isActive = true
        
        darkLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        darkLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14).isActive = true
        darkLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        darkLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:14).isActive = true
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let appCount = appCategories?.apps?.count {
            return appCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCells
        cell.apps = appCategories?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height-30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
}

class AppCells: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var apps: App? {
        didSet {
            if let appName = apps?.name {
                nameLabel.text = appName
            }
            if let category = apps?.category {
                entertainmentLabel.text = category
            }
            if let price = apps?.price {
                priceLabel.text = "$\(price)"
            }
        }
    }
    
    let thumbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "banjotooiecrop")
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "This is by Disney"
        return label
    }()
    
    let entertainmentLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.text = "Entertainment"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.text = "$13.5"
        return label
    }()
    
    func setupView() {
        backgroundColor = .clear
        
        [thumbnailImageView, nameLabel, entertainmentLabel, priceLabel].forEach { addSubview($0) }
        
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width+2, width: frame.width, height: 40)
        entertainmentLabel.frame = CGRect(x: 0, y: frame.width+38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width+56, width: frame.width, height: 20)
        
    }
}

