//
//  LocationsListView.swift
//  TourMap
//
//  Created by Richard Crichlow on 10/2/23.
//

import SwiftUI
import MapKit

struct LocationsListView: View {
    @Binding var camera: MapCameraPosition // Binding to update the camera position
    @Environment(\.presentationMode) var presentationMode // Access the presentation mode
    
    var body: some View {
        NavigationView {
            List(Tour.allLocations) { location in
                Button(action: {
                    camera = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            latitudinalMeters: 200,
                            longitudinalMeters: 200))
                    
                    presentationMode.wrappedValue.dismiss() // Dismiss the modal sheet when a location is tapped
                }) {
                    Text(location.name)
                }
            }
            .navigationTitle("Locations") // Set the navigation title
        }
    }
}
