//
//  ViewController.swift
//  EczaneApp
//
//  Created by Şakir Yılmaz ÖĞÜT on 27.01.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
                 longitude: 29.1066199)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
}


