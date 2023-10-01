//
//  ContentView.swift
//  TourMap
//
//  Created by Richard Crichlow on 9/27/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var camera: MapCameraPosition = .automatic
    let tour = Tour()
    
    var body: some View {
        Map(position: $camera) {
        // TODO: Change to ForEach
            Marker("Spark CDI",
                   systemImage: "building",
                   coordinate: tour.sparkcdigeocode)
            
            Marker("Great Plains Black History Museum",
                   systemImage: "building.columns",
                   coordinate: tour.greatPlainsBlackHistoryMuseum)
            
            Marker("culxr House",
                   systemImage: "building",
                   coordinate: tour.culxrHouse)
        }
        .mapStyle(.imagery)
        .safeAreaInset(edge: .bottom) {
            // TODO: Change to a List
            VStack(spacing: 4) {
                HStack(spacing: 20) {
                    // TODO: Change to ForEach
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: tour.sparkcdigeocode,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Spark CDI")
                    }
                    
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: tour.culxrHouse,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("culxr House")
                    }
                    
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: tour.greatPlainsBlackHistoryMuseum,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Great Plains Black History Museum")
                    }
                    
                    Button {
                        // Reset
                        camera = .automatic
                    } label: {
                        Text("TODO: Undo Icon")
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
