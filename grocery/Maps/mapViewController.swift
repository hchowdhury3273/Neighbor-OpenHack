//
//  mapViewController.swift
//  grocery
//
//  Created by Helal Chowdhury on 3/29/20.
//  Copyright © 2020 Helal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var iCarouselView: iCarousel!
    
    var imageArr = [
            UIImage(named: "yasinCard"),
            UIImage(named: "mengCard"),
            UIImage(named: "rageebCard"),
        ]
        
        
        let locationManager = CLLocationManager()
        var currentCoordinate: CLLocationCoordinate2D?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            carouselSetup()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapView.delegate = self
            userLocationSetup()
            self.mapSetup()

        }
        
        func carouselSetup(){
            iCarouselView.type = .cylinder
            iCarouselView.contentMode = .scaleAspectFill
            iCarouselView.isPagingEnabled = true
        }
        
        func mapSetup() {
    //        self.mapView.mapType = .hybridFlyover
            self.mapView.showsBuildings = true
            self.mapView.isZoomEnabled = true
            self.mapView.isScrollEnabled = true
            
    //        let camera = FlyoverCamera(mapView: self.mapView, configuration: FlyoverCamera.Configuration(duration: 3.0, altitude: 30500, pitch: 45.0, headingStep: 40.0))
    //        camera.start(flyover: FlyoverAwesomePlace.newYork)
    //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(200), execute:{
    //            camera.stop()
    //        })
        }
        
        func userLocationSetup(){
            locationManager.requestAlwaysAuthorization() //we can ask this later
            locationManager.startUpdatingLocation()
            locationManager.distanceFilter = 100
            mapView.showsUserLocation = true
    //        mapView.mapType = MKMapType.hybrid
        }
        
        func addAnnotations(){

           let timesSqaureAnnotation = MKPointAnnotation()
           timesSqaureAnnotation.title = "Yasin Ehsan"
           timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.680142, longitude: -73.840553)
            
           
           let empireStateAnnotation = MKPointAnnotation()
           empireStateAnnotation.title = "Rageeb Mahtab"
           empireStateAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.686326, longitude: -73.853814)
            
            
           let brooklynBridge = MKPointAnnotation()
           brooklynBridge.title = "Meng Shi"
           brooklynBridge.coordinate = CLLocationCoordinate2D(latitude: 40.693680, longitude: -73.828323)

           
//           let prospectPark = MKPointAnnotation()
//           prospectPark.title = "Clinique - Bath Ave"
//           prospectPark.coordinate = CLLocationCoordinate2D(latitude: 40.6602, longitude: -73.9690)
//
//
//           let jersey = MKPointAnnotation()
//           jersey.title = "Clinique - Hoboken"
//           jersey.coordinate = CLLocationCoordinate2D(latitude: 40.7178, longitude: -74.0431)
//
//            let curr = MKPointAnnotation()
//            curr.coordinate = CLLocationCoordinate2D(latitude: 40.7508, longitude: -73.9387)
            
    //        var geofenceList = [CLCircularRegion]()
    //        let locations = [timesSqaureAnnotation.coordinate, empireStateAnnotation.coordinate, brooklynBridge.coordinate, prospectPark.coordinate, jersey.coordinate]
    //        for coor in locations{
    //            geofenceList.append(CLCircularRegion(center: coor, radius: 800, identifier: "geofence"))
    //        }
    //        for fence in geofenceList {
    //            let circle = MKCircle(center: fence.center, radius: fence.radius)
    //            circle.title = fence.identifier
    //            mapView.addOverlay(circle)
    //        }
           
           mapView.addAnnotation(timesSqaureAnnotation)
           mapView.addAnnotation(empireStateAnnotation)
           mapView.addAnnotation(brooklynBridge)
//           mapView.addAnnotation(prospectPark)
//           mapView.addAnnotation(jersey)

        }
        
        func showRoute() {
            let sourceLocation = currentCoordinate ?? CLLocationCoordinate2D(latitude: 40.680142, longitude: -73.840553)
            let destinationLocation = CLLocationCoordinate2D(latitude: 40.680142, longitude: -73.840553)
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate {(response, error) in
                guard let directionResponse = response else {
                    if let error = error{
                        print("There was an error getting directions==\(error.localizedDescription)")
                    }
                    return
                }
                let route = directionResponse.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                 //below not being called set Region two more
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            self.mapView.delegate = self
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
             let renderer = MKPolylineRenderer(overlay: overlay)
                   renderer.strokeColor = UIColor.blue
                   renderer.lineWidth = 4.0
                   return renderer
        }

    


    }
    extension mapViewController: MKMapViewDelegate {

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            else{
                let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")

                pin.canShowCallout = true
//                pin.image = UIImage(named: "pinYasin")
                
                pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return pin
            }
        }
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            showRoute()
        }
        
        
      
    }
    extension mapViewController: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            locationManager.stopUpdatingLocation()
            
            self.mapView.showsUserLocation = true
            guard let latestLocation = locations.first else { return }
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: latestLocation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            if currentCoordinate == nil{
    //            zoomIn(latestLocation.coordinate)
                addAnnotations()
            }
            
            currentCoordinate = latestLocation.coordinate
            
        }
    }

    extension mapViewController: iCarouselDelegate, iCarouselDataSource{
        func numberOfItems(in carousel: iCarousel) -> Int {
            return imageArr.count
        }
        
        func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
            var imageView: UIImageView!
            if view == nil{
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 250))
                imageView.contentMode = .scaleAspectFit
            } else {
                imageView = view as? UIImageView
            }
            imageView.image = imageArr[index]
            return imageView
        }
        
    }
