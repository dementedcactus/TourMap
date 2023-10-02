//
//  MapTOurVIew.swift
//  TourMap
//
//  Created by Richard Crichlow on 9/27/23.
//

import SwiftUI
import MapKit

struct MapTOurVIew: View {
    @State var camera: MapCameraPosition = .automatic
    @State var isShowingLocationsList = false
    
    var body: some View {
        Map(position: $camera) {
            
            ForEach(Tour.allLocations) { location in
                Marker(location.name,
                       systemImage: "building",
                       coordinate: location.coordinate)
            }
        }
        .mapStyle(.imagery)
        .sheet(isPresented: $isShowingLocationsList) {
            LocationsListView(camera: $camera) // Present a modal list view with camera binding
        }
        .safeAreaInset(edge: .bottom) {
            // TODO: Change to LocationsListView
            VStack(spacing: 4) {
                HStack(spacing: 20) {
                    Button(action: {
                        isShowingLocationsList.toggle()
                    }) {
                        Image(systemName: "list.bullet") // Use a list icon to open the locations list
                            .font(.title)
                            .foregroundColor(Color.blue)
                    }
                    .tint(.green)
                    
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
    MapTOurVIew()
}
