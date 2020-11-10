//
//  AlbumViewControllerCollectionView.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/14/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import Foundation
import UIKit

extension AlbumViewController {
    func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        DispatchQueue.main.async {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView!.collectionViewLayout = layout
        }
    }
}

