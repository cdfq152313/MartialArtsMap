//
//  GYMDetailViewController.swift
//  MartialArtsMap
//
//  Created by denny on 10/26/16.
//  Copyright © 2016 denny. All rights reserved.
//

import UIKit
import MapKit

class GYMDetailViewController: UIViewController {
    @IBOutlet weak var gymNameLabel: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func editAction(_ sender: AnyObject) {
        
    }
    
    @IBAction func openURL(_ sender: AnyObject) {
        if let url = URL(string: gymInfo!.website){
            UIApplication.shared.openURL(url)
        }
        else{
            // TODO
            // add alert action
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gymNameLabel.title = gymInfo?.name
        descriptionField.text = gymInfo?.description
        initMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var gymInfo:GYMInfo?
    let geoCoder = CLGeocoder()
    
    func initMap(){
        guard let address = gymInfo?.address else{
            print("No Address")
            return
        }

        geoCoder.geocodeAddressString(address) {
            (places, error) in
            guard error == nil else {
                print ("Get position error")
                return
            }
            
            if(places?.count)! > 0 {
                let placeMark = places?.first
                print("Location: \(placeMark?.location)")
                
                // add notation
                let annotation = MKPointAnnotation()
                annotation.title = self.gymInfo?.name
                annotation.subtitle = address
                annotation.coordinate = (placeMark?.location?.coordinate)!
                self.mapView.addAnnotation(annotation)
                
                // set region
                let span = MKCoordinateSpanMake(0.075, 0.075)
                let cl2d = CLLocationCoordinate2D(latitude: (placeMark?.location?.coordinate.latitude)!, longitude: (placeMark?.location?.coordinate.longitude)!)
                let region = MKCoordinateRegion(center: cl2d, span: span)
                self.mapView.setRegion(region, animated: true)
                placeMark!.location?.coordinate
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
