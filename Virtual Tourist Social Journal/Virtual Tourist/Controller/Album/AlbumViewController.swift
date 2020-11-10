//
//  AlbumViewController.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import MapKit

class AlbumViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noImagesLbl: UILabel!
    @IBOutlet weak var done: UIBarButtonItem!
  
    //MARK: VARS
    
    var databaseManager: DatabaseManager!
    var place: Place!
    var selectedImagesIndicesToDelete = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    var currentPageNumber:Int = 0
    var album: [Image]! = [Image]() {
        didSet {
            checkIfEmptyAlbum()
        }
    }
    
    //MARK: VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchResultController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        startWaitingIndicator()
        configureUI()
        configureMapView()
        self.configureCollectionView()
 
        guard let _ = place.images, place.images?.count ?? 0 > 0 else {
            loadAlbumImagesFromNetwork()
            return
        }
        stopWaitingIndicator()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseManager.resetFetchResultController()

    }
  
    //MARK: Collection and Image
    
    private func checkIfEmptyAlbum() {
        if album.count == 0 {
            DispatchQueue.main.async {
                self.noImagesLbl.isHidden = false
            }
        }
    }
    
    @IBAction func newCollection(_ sender: Any) {
        reloadNewImages()
    }
    
    func reloadNewImages() {
        deleteAllAlbumImagesFromDB()
        currentPageNumber += 1
        loadAlbumImagesFromNetwork()
    }


}


