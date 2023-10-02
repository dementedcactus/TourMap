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
    
    var body: some View {
        Map(position: $camera) {
            
            ForEach(Tour.allLocations) { location in
                Marker(location.name,
                       systemImage: "building",
                       coordinate: location.coordinate)
            }
        }
        .mapStyle(.imagery)
        .safeAreaInset(edge: .bottom) {
            // TODO: Change to a Modal that slides up from the bottom
            VStack(spacing: 4) {
                HStack(spacing: 20) {
                    // TODO: Change to ForEach
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: Tour.sparkcdigeocode,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Spark CDI")
                    }
                    
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: Tour.culxrHouse,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("culxr House")
                    }
                    
                    Button {
                        camera = .region(
                            MKCoordinateRegion(
                                center: Tour.greatPlainsBlackHistoryMuseum,
                                latitudinalMeters: 200,
                                longitudinalMeters: 200))
                    } label: {
                        Text("Great Plains Black History Museum")
                    }
                    
                    Button { // Reset Map
                        camera = .automatic
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle")
                                .font(.title)
                                .foregroundColor(.red)
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
