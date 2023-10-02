//
//  Tour.swift
//  TourMap
//
//  Created by Richard Crichlow on 9/30/23.
//

import Foundation
import MapKit

struct Location: Identifiable {
    var id = UUID()  // Assign a unique identifier to each location
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id  // Implement equality check based on IDs
    }
    
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct Tour: Identifiable {
    var id = UUID()
    
    static let culxrHouse = CLLocationCoordinate2D(
        latitude: 41.28673437517158,
        longitude: -95.94704840926867)
    static let greatPlainsBlackHistoryMuseum = CLLocationCoordinate2D(
        latitude: 41.27968147294707,
        longitude: -95.9463017227632)
    static let sparkcdigeocode = CLLocationCoordinate2D(
        latitude: 41.272385436064326,
        longitude: -95.9323270281948)
    static let salemBaptistChurch = CLLocationCoordinate2D(
        latitude: 41.2931,
        longitude: -95.9275)
    static let theGreatPlainsBlackHistoryMuseum = CLLocationCoordinate2D(
        latitude: 41.2853,
        longitude: -95.9381)
    static let theLovesJazzArtsCenter = CLLocationCoordinate2D(
        latitude: 41.2822,
        longitude: -95.9380)
    static let theEaglsNestWorshipCenter = CLLocationCoordinate2D(
        latitude: 41.2992,
        longitude: -95.9592)
    static let omahaNorthHighSchool = CLLocationCoordinate2D(
        latitude: 41.2986,
        longitude: -95.9384)
    static let the30thAmesCommercialCenter = CLLocationCoordinate2D(
        latitude: 41.2958,
        longitude: -95.9384)
    static let theUnionForContemporaryArt = CLLocationCoordinate2D(
        latitude: 41.2840,
        longitude: -95.9374)
    static let theBryantCenter = CLLocationCoordinate2D(
        latitude: 41.2847,
        longitude: -95.9570)
    static let fairDealMarketPlace = CLLocationCoordinate2D(
        latitude: 41.2691,
        longitude: -95.9328)
    static let theCarverBank = CLLocationCoordinate2D(
        latitude: 41.2642,
        longitude: -95.9322)
    
    static var allLocations: [Location] {
        return [
            Location(name: "culxr House", coordinate: culxrHouse),
            Location(name: "Great Plains Black History Museum", coordinate: greatPlainsBlackHistoryMuseum),
            Location(name: "Spark CDI", coordinate: sparkcdigeocode),
            Location(name: "Salem Baptist Church", coordinate: salemBaptistChurch),
            Location(name: "The Great Plains Black History Museum", coordinate: theGreatPlainsBlackHistoryMuseum),
            Location(name: "The Loves Jazz Arts Center", coordinate: theLovesJazzArtsCenter),
            Location(name: "The Loves Jazz Arts Center", coordinate: theLovesJazzArtsCenter),
            Location(name: "The Eagles Nest Worship Center", coordinate: theEaglsNestWorshipCenter),
            Location(name: "Omaha North High School", coordinate: omahaNorthHighSchool),
            Location(name: "The 30th Ames Commercial Center", coordinate: the30thAmesCommercialCenter),
            Location(name: "The Union For Contemporary Art", coordinate: theUnionForContemporaryArt),
            Location(name: "The Bryant Center", coordinate: theBryantCenter),
            Location(name: "Fair Deal Marketplace", coordinate: fairDealMarketPlace),
            Location(name: "The Carver Bank", coordinate: theCarverBank),
        ]
    }
}
