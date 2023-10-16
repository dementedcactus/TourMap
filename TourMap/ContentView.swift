//
//  ContentView.swift
//  TourMap
//
//  Created by Richard Crichlow on 10/2/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    @State private var showPrioritizedLocations = false

    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            
            Annotation("My location", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/.opacity(0.25))
                    
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.blue)
                }
            }
            
            // Prioritized Locations To Always Show Go Here
            if showPrioritizedLocations {
                Marker("Spark CDI", systemImage: "building", coordinate: Tour.sparkcdigeocode)
                Marker("Great Plains Black History Museum", systemImage: "building.columns", coordinate: Tour.greatPlainsBlackHistoryMuseum)
                Marker("culxr House", systemImage: "building", coordinate: Tour.culxrHouse)
            }

            // Search Results
            ForEach(results, id: \.self) { item in
                if routeDisplaying {
                    if item == routeDestination {
                        let placemark = item.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                } else {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            }
            
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 6)
            }
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                showPrioritizedLocations.toggle()
                
                if showPrioritizedLocations {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 41.28673437517158, longitude: -95.94704840926867),
                        latitudinalMeters: 10000,
                        longitudinalMeters: 10000
                    ))
                } else {
                    cameraPosition = .region(.userRegion)
                }
            }) {
                Text(showPrioritizedLocations ? "Hide Prioritized Locations" : "Show Prioritized Locations")
                    .foregroundColor(.blue)
            }
        }
        .overlay(alignment: .top) {
            VStack {
                HStack {
                    if routeDisplaying {
                        Button(action: {
                            clearRoute()
                        }) {
                            Image(systemName: "arrow.left.circle")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        .tint(.blue)
                    }
                    
                    TextField("Search for a location", text: $searchText)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .padding()
                        .shadow(radius: 10)
                    
                }
                .padding(.horizontal, 40)
                
            }
        }
        .onSubmit(of: .text) {
            print("Search for locations with query \(searchText)")
            Task { await searchPlaces() }
        }
        .onChange(of: getDirections, { oldValue, newValue in
            if newValue {
                fetchRoute()
            }
        })
        .onChange(of: mapSelection, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            LocationDetailsView(mapSelection: $mapSelection,
                                show: $showDetails,
                                getDirections: $getDirections)
            .presentationDetents([.height(340)])
            .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
            .presentationCornerRadius(12)
        })
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}

extension ContentView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
    
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = mapSelection
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                    
                    if let rect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(rect)
                    }
                }
            }
        }
    }
    
    func clearRoute() {
        routeDisplaying = false
        route = nil
        routeDestination = nil
        cameraPosition = .region(.userRegion)
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 41.28673437517158, longitude: -95.94704840926867)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 10000,
                     longitudinalMeters: 10000)
    }
}

#Preview {
    ContentView()
}
