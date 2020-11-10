import MapKit
import CoreLocation
 
extension AlbumViewController{
    func configureMapView() {
        let span = MKCoordinateSpan(latitudeDelta: 2.2, longitudeDelta: 4.3)
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: place.latitude)!, longitude: CLLocationDegrees(exactly: place.longitude)!)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.isZoomEnabled = false
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.isUserInteractionEnabled = false
        mapView.setRegion(region, animated: true)
        addAnnotationToMap(with: coordinate)
    }
    
    func addAnnotationToMap(with coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

