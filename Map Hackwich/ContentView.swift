//
//  ContentView.swift
//  Map Hackwich
//
//  Created by Tom Bredemeier on 3/1/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 42.15704,
            longitude: -88.14812),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05)
    )
    @State private var places = [Place(name: "Barrington High School",
                        coordinate: CLLocationCoordinate2D(
                            latitude: 42.15704, longitude: -88.14812))]
    
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: places) { place in
            MapAnnotation(coordinate: place.coordinate,
                          anchorPoint: CGPoint(x: 0.5, y: 1.5)) {
                Marker(name: place.name)
            }
        }
        .onAppear {
            findLocation(name: "Springfield")
        }
    }
    
    func findLocation(name: String) {
        locationManager.geocoder.geocodeAddressString(name) { (placemarks, error) in
            if let placemark = placemarks?.first {
                let place = Place(name: placemark.name!,
                                  coordinate: placemark.location!.coordinate)
                places.append(place)
            } else {
                print("Could not locate \(name)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Marker: View {
    var name: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 30, height: 30, alignment: .center)
                .rotationEffect(.degrees(45))
            Capsule()
                .fill(Color.red)
                .frame(width: 200, height: 30, alignment: .center)
            Text(name)
        }
    }
}
