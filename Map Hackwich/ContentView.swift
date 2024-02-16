//
//  ContentView.swift
//  Map Hackwich
//
//  Created by Tom Bredemeier on 2/16/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State private var startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: 42.15559,
            longitude: -88.14692),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05)
        )
    )
    @State private var places = [Place(name: "Barrington High School",
                        coordinate: CLLocationCoordinate2D(
                            latitude: 42.1565, longitude: -88.1480))]
    var body: some View {
        Map(position: $startPosition) {
            UserAnnotation()
            ForEach(places) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(.circle)
                }

            }


        }
    }
}

#Preview {
    ContentView()
}

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
