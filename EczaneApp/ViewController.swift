//
//  ViewController.swift
//  EczaneApp
//
//  Created by Şakir Yılmaz ÖĞÜT on 27.01.2025.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var isShowingMap = false
    
    @IBAction func rightBarButton(_ sender: UIBarButtonItem) {
        isShowingMap.toggle()
        updateView()
    }
    
    private func updateView() {
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = self.isShowingMap ? 0 : 1
            self.mapView.alpha = self.isShowingMap ? 1 : 0
        }
        
        let buttonImage = UIImage(systemName: self.isShowingMap ? "list.bullet" : "map")
        navigationItem.rightBarButtonItem?.image = buttonImage
    }
    
    var pharmacies: [Pharmacy] = [
        Pharmacy(name: "Ataşehir Metropol Eczanesi",
                 address: "Atatürk, Ataşehir Blv. Ata - 3 Plaza Altı) No:14/C, 34758 Ataşehir/İstanbul",
                 latitude: 40.9928218,
                 longitude: 29.1243973),
        Pharmacy(name: "Ata Eczanesi",
                 address: "Ata 4/4 Çarşı, Atatürk, Ataşehir Blv. 18 E, 34750 Ataşehir",
                 latitude: 40.9925292,
                 longitude: 29.1261531),
        Pharmacy(name: "Yeni Andromeda Eczanesi",
                 address: "Barbaros Mahallesi, Morleylak Sokağı, Ağaoğlu Myworld Andromeda Sitesi İçi, 34746 Ataşehir/İstanbul",
                 latitude: 40.9916232,
                 longitude: 29.1066199),
        Pharmacy(name: "Sevgi Eczanesi",
                 address: "Fatih Sultan Mahallesi, Kanuni Sultan Süleyman Bulvari No:30/D, 27700 Nizip/Gaziantep",
                 latitude: 37.0123241,
                 longitude: 37.811932),
        Pharmacy(name: "Botanik Eczanesi",
                 address: "Gürselpaşa, Șehit Polis Șahin Polat Aydın Bl. NO:23/E E BLOK, 01200 Seyhan/Adana",
                 latitude: 37.0162627,
                 longitude: 35.2606936),
        Pharmacy(name: "Aslı Eczanesi",
                 address: "Tatlısu, Tezcan Cd. 60/1, 34774 Ümraniye/İstanbul",
                 latitude: 40.9992984,
                 longitude: 29.1371126)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupMap()
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        mapView.alpha = 0
        navigationItem.title = "Nöbetçi Eczaneler"
    }
    
    private func setupMap() {
        mapView.delegate = self
        
        for pharmacy in pharmacies {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pharmacy.latitude, longitude: pharmacy.longitude)
            annotation.title = pharmacy.name
            annotation.subtitle = pharmacy.address
            mapView.addAnnotation(annotation)
        }
        
        if let firstPharmacy = pharmacies.first {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: firstPharmacy.latitude, longitude: firstPharmacy.longitude),
                latitudinalMeters: 5000,
                longitudinalMeters: 5000
            )
            mapView.setRegion(region, animated: false)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyCell", for: indexPath)
        cell.textLabel?.text = pharmacies[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            detailVC.selectedPharmacy = pharmacies[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let pharmacy = pharmacies.first(where: {
            $0.latitude == annotation.coordinate.latitude &&
            $0.longitude == annotation.coordinate.longitude
        }) {
            if let detailVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
                detailVC.selectedPharmacy = pharmacy
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
