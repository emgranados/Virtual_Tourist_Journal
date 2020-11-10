//
//  MapViewController.swift
//  Virtual Tourist
//
//  Created by Edwina Granados on 10/11/19.
//  Copyright © 2019 Edwina Granados. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var removePinText: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var edit: UIBarButtonItem!
    @IBOutlet weak var information: UIBarButtonItem!
    @IBOutlet weak var fixedSpace: UIBarButtonItem!
    
    //MARK: VARs
    
    var databaseManager: DatabaseManager!
    var places: [PutAnnotation]!
    var isDeletingMode = false {
        didSet {
            removePinText.isHidden = !isDeletingMode
        }
    }
    //MARK: Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        setupFetchResultController()
        loadAllPlaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startWaitingIndicator()
        configureUI()
        addMapGestures()
        showPinsOnMapForAllPlaces()
        stopWaitingIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseManager.resetFetchResultController()
    }
    
    //MARK: Actions
    @IBAction func deletingMode(_ sender: UIBarButtonItem) {
        isDeletingMode = !isDeletingMode
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: (isDeletingMode) ? .done : .edit, target: self, action: #selector(deletingMode(_:)))
    }
    
    @IBAction func information(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "This is how to use my application", message: "Tap, hold, then release to drop a pin in your desired location." , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}
extension MapViewController {
    func openAlbumViewController(for place: Place) {
        DispatchQueue.main.async {
            let albumViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
            albumViewController.place = place
            self.navigationController?.pushViewController(albumViewController, animated: false)
        }
    }
}
 
