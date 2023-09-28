//
//  ContentView.swift
//  TourMap
//
//  Created by Richard Crichlow on 9/27/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let culxrHouse = CLLocationCoordinate2D(latitude: 41.28673437517158, longitude: -95.94704840926867)
    let greatPlainsBlackHistoryMuseum = CLLocationCoordinate2D(latitude: 41.27968147294707, longitude: -95.9463017227632)
    let sparkcdigeocode = CLLocationCoordinate2D(latitude: 41.272385436064326, longitude: -95.9323270281948)
    
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $camera) {
            
            Marker("Spark CDI", systemImage: "building", coordinate: sparkcdigeocode)
            
            Marker("Great Plains Black History Museum", systemImage: "building.columns",coordinate: greatPlainsBlackHistoryMuseum)
            
            Marker("culxr House", systemImage: "building",coordinate: culxrHouse)
        }
        .mapStyle(.imagery)
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 4) {
                HStack(spacing: 20) {
                    Button {
                        // Center on SparkCDI
                        camera = .region(
                            MKCoordinateRegion(
                                center: sparkcdigeocode,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Spark CDI")
                    }
                    
                    Button {
                        // Center on culxrHouse
                        camera = .region(
                            MKCoordinateRegion(
                                center: culxrHouse,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("culxr House")
                    }
                    
                    Button {
                        // Center on Great Plains Black History Museum
                        camera = .region(
                            MKCoordinateRegion(
                                center: greatPlainsBlackHistoryMuseum,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Great Plains Black History Museum")
                    }
                    
                    Button {
                        // Reset
                        camera = .automatic
                    } label: {
                        Text("Undo Icon")
                    }
                    .tint(.red)
                }
                .background(.thinMaterial)
                .padding(4)
            }
            .padding(4)
        }
    }
}

#Preview {
    ContentView()
}
