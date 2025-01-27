//
//  DetailViewController.swift
//  EczaneApp
//
//  Created by Şakir Yılmaz ÖĞÜT on 27.01.2025.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selectedPharmacy: Pharmacy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pharmacy = selectedPharmacy {
            title = pharmacy.name
            
            let coordinate = CLLocationCoordinate2D(latitude: pharmacy.latitude, longitude: pharmacy.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = pharmacy.name
            annotation.subtitle = pharmacy.address
            
            mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
} 
